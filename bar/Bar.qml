import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs.popups
import qs.services

Item {
  id: root

  anchors.left: parent.left
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  implicitWidth: Tokens.barSize

  Icon {
    id: logo
    icon: ""
    anchors.top: parent.top
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    color: "#cba6f7"
  }

  Workspaces {
    id: workspaces
    anchors.top: logo.bottom
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
  }

  Item {
    // anchors.fill: winTitleText
    anchors.top: workspaces.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 20

    implicitWidth: winTitleText.height
    implicitHeight: winTitleText.width

    StyledText {
      id: winTitleText
      anchors.centerIn: parent
      text: ""
      rotation: -90
      property string newTitle: Niri.winTitle
      onNewTitleChanged: {
        anim.restart()
      }

      SequentialAnimation {
        id: anim
        NumberAnimation {
          target: winTitleText
          property: "opacity"
          duration: 150
          to: 0
        }
        ScriptAction { 
          script: winTitleText.text = winTitleText.newTitle
        }
        NumberAnimation {
          target: winTitleText
          property: "opacity"
          duration: 300
          to: 1
        }
      }
    }
  }


  ColumnLayout {
    width: parent.width
    anchors.bottom: power.top
    anchors.bottomMargin: 10
    spacing: 10

    Clock {
      Layout.alignment: Qt.AlignHCenter
    }

    Tray {
      Layout.alignment: Qt.AlignHCenter
    }
  }

  Icon {
    id: power
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 15

    icon: ""
    textSize: 18
    color: "#f38ba8"

    MouseArea {
      anchors.fill: parent
      onClicked: {
        PopupComm.blComponent = powerbuttons
        PopupComm.showBL(520, 120)
      }

      Component {
        id: powerbuttons
        Item {
          anchors.fill: parent
          anchors.margins: 28
          opacity: parent.width >= 300 ? 1 : 0
          Behavior on opacity { NumberAnimation { duration: 250 } }

          RowLayout {
            spacing: 15
            anchors.centerIn: parent

            StyledText {
              text: "Bye\nBye"
              font.pointSize: 18
              Layout.margins: 10
            }

            Button {
              id: sleep
              icon: ""
              command: [ "systemctl", "suspend" ]
            }

            Button {
              id: hibernate
              icon: ""
              command: [ "systemctl", "hibernate"]
            }

            Button {
              id: restart
              icon: ""
              command: [ "systemctl", "reboot" ]
            }

            Button {
              id: power
              icon: ""
              color: "#11111b"
              shapeColor: "#eba0ac"
              command: [ "systemctl", "poweroff" ]
            }


            component Button : MaterialButton {
              Layout.alignment: Qt.AlignHCenter
              anchors.leftMargin: 14
              height: 80
              width: 80
            }
          }


        }
      }
    }
  }
}
