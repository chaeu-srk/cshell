import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import M3Shapes
import qs.services
import qs.components

Item {
  anchors.fill: parent
  anchors.margins: 10
  opacity: parent.height >= 500 ? 1 : 0
  Behavior on opacity {
    NumberAnimation { duration: 250 }
  }

  // Rectangle {
  //   anchors.fill: parent
  //   color: "#313244"
  //   radius: 20
  // }

  Item {
    id: topBar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 80
  }

  Rectangle {
    anchors.left: parent.left
    anchors.right: sys.left
    anchors.bottom: clock.top
    anchors.top: topBar.bottom
    anchors.margins: 10
    anchors.leftMargin: 0
    anchors.topMargin: 0

    radius: 35
    color: "#1e1e2e"

    Calender {
      anchors.centerIn: parent
    }
  }

  Rectangle {
    id: sys
    anchors.bottom: clock.top
    anchors.top: topBar.bottom
    anchors.right: player.left
    anchors.margins: 10
    anchors.topMargin: 0

    radius: 20
    width: 240
    color: "#1e1e2e"

    MaterialShapeMask {
      id: profile
      implicitWidth: 200
      implicitHeight: 200
      anchors.top: parent.top
      anchors.topMargin: 40
      anchors.horizontalCenter: parent.horizontalCenter
      source: Quickshell.env("HOME") + "/.face"
      shape: Math.floor(Math.random() * 28)

      MouseArea {
        anchors.fill: parent
        onClicked: {
          parent.shape = Math.floor(Math.random() * 28)
        }
      }
    }

    StyledText {
      anchors.top: profile.bottom
      anchors.topMargin: 10
      anchors.horizontalCenter: parent.horizontalCenter
      id: user
      text: "chaeu@nixos"
      font.pointSize: 18
    }

    Item {
      anchors.top: user.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: uptext.implicitWidth + up.implicitWidth
      implicitHeight: uptext.implicitHeight + up.implicitHeight

      StyledText {
        id: uptext
        text: "up: "
        color: "#cba6f7"
        font.pointSize: 13
      }

      StyledText {
        id: up
        anchors.left: uptext.right
        text: uptimeString
        font.pointSize: 13
        font.bold: true
        color: "#a6adc8"
        property string uptimeString

        FileView {
          id: uptime_file
          path: "/proc/uptime"
          onLoaded: {
            const seconds = Math.floor(parseFloat(text().split(" ")[0]))
            up.uptimeString = formatUptime(seconds)
          }
          function formatUptime(seconds) {
            const hours = Math.floor((seconds % 86400) / 3600)
            const minutes = Math.floor((seconds % 3600) / 60)

            return `${hours} hours ${minutes} mins`
          }
        }
      }
    }
  }

  MusicPlayer {id: player}

  Rectangle {
    anchors.left: clock.right
    anchors.right: player.left
    anchors.bottom: parent.bottom
    anchors.margins: 10
    anchors.bottomMargin: 0

    height: clock.height
    radius: 20
    color: "#1e1e2e"

    AnimatedImage {
      anchors.fill: parent
      anchors.margins: 10
      source: "../assets/bongocat.gif"
      fillMode: Image.PreserveAspectFit
    }
  }


  Rectangle {
    id: clock
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    width: 350
    height: 100

    radius: 20
    color: "#181825"

    StyledText {
      // anchors.left: parent.left
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.margins: 10
      text: System.time
      font.pointSize: 28
    }
    StyledText {
      text: System.date
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.margins: 10
      font.pointSize: 18
      color: "#6c7086"
    }
  }
}
