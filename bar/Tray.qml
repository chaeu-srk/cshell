import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import M3Shapes
import qs.components
import qs.config
import qs.services
import qs.popups

Item {
  property real mariginLR: 14
  width: parent.width - mariginLR
  implicitHeight: layout.implicitHeight + width / 2

  Rectangle {
    anchors.fill: parent
    color: "#1e1e2e"
    radius: width / 2
  }

  ColumnLayout {
    anchors.centerIn: parent
    id: layout
    width: parent.width
    spacing: 10

    IconLay {
      icon: System.wifiIcon
      textSize: 15
      MouseArea {
        anchors.fill: parent
        onClicked: {
          PopupComm.blComponent = wifiMenu
          PopupComm.showBL(400, 300)
        }
      }
    }

    IconLay {
      icon: System.btIcon
      MouseArea {
        anchors.fill: parent
        onClicked: {
          PopupComm.blComponent = btMenu
          PopupComm.showBL(400, 200)
        }
      }
    }

    IconLay {
      icon: System.batteryIcon
      color: System.charging ? "#f9e2af" :
      (System.batteryPercent < 25) ? "#f38ba8" : Tokens.text

      MouseArea {
        anchors.fill: parent
        onClicked: {
          PopupComm.blComponent = batteryMenu
          PopupComm.showBL(500, 200)
        }
      }
    }
  }

  Component {
    id: batteryMenu
    Item {
      opacity: parent.height > 150 ? 1 : 0
      Behavior on opacity { NumberAnimation { duration: 250 } }
      anchors.fill: parent
      anchors.margins: 20
      property real bat: System.batteryFloat <= 0.17 ? 0.17 : System.batteryFloat

      RowLayout {
        spacing: 10

        AltMaterialButton {
          icon: ""
          baseShape: System.isPowerSaver ? MaterialShape.Gem : MaterialShape.Square
          MouseArea {
            anchors.fill: parent
            onClicked: {
              System.set_power_profile(1)
            }
          }
        }

        AltMaterialButton {
          icon: ""
          baseShape: System.isBalanced ? MaterialShape.Gem : MaterialShape.Square
          MouseArea {
            anchors.fill: parent
            onClicked: {
              System.set_power_profile(2)
            }
          }
        }

        AltMaterialButton {
          icon: "󱀚"
          baseShape: System.isPerformance ? MaterialShape.Gem : MaterialShape.Square
          MouseArea {
            anchors.fill: parent
            onClicked: {
              System.set_power_profile(3)
            }
          }
        }
      }

      Rectangle {
        anchors.bottom: parent.bottom
        height: 70
        width: parent.width * bat - 4

        radius: 12
        color: {
          if (System.charging) {
            return "#f9e2af"
          } else if (System.batteryPercent <= 25) {
            return "#e78284"
          }
          return "#a6d189"
        }

        StyledText {
          id: percent
          text: String(System.batteryPercent) + "%"
          color: "#11111b"
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: 8
          anchors.leftMargin: 8
          font.pointSize: 22
        }
        StyledText {
          text: "BAT" + (System.charging ? "" : "")
          color: "#11111b"
          anchors.left: percent.left
          anchors.top: percent.bottom
          anchors.topMargin: -4
        }
      }

      Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 70
        width: parent.width * (1 - bat) - 4
        radius: 12
        color: "#45475a"
      }
    }
  }

  Component {
    id: wifiMenu
    Item {
      anchors.fill: parent
      anchors.margins: 20

      Rectangle {
        width: parent.width
        implicitHeight: 50
        color: "#313244"
        radius: 10

        Icon {
          id: icon
          icon: System.wifiIcon
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          anchors.leftMargin: 15
        }

        StyledText {
          text: System.get_current_wifi_name()
          anchors.left: icon.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.leftMargin: 15
        }
      }
    }
  }

  Component {
    id: btMenu
    Item {
      anchors.fill: parent
      anchors.margins: 20
      StyledText {
        text: "Working on it!"
        font.pointSize: 24
        anchors.centerIn: parent
      }
    }
  }

  component IconLay : Icon {
    Layout.alignment: Qt.AlignHCenter
  }
}
