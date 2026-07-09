import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.components
import M3Shapes

Item {
  id: root
  implicitWidth: 380
  implicitHeight: 220

  property string uptime: ""
  property string os: ""

  Rectangle {
    id: bg
    anchors.fill: parent
    radius: 20
    color: "#1e1e2e"
  }
  
  Item {
    anchors.fill: parent
    anchors.margins: 12
    StyledText {
      id: header
      text: "fetch ~"
    }

    MaterialShapeMask {
      id: logo
      anchors.top: header.bottom
      implicitWidth: 150
      implicitHeight: 150
      source: "/home/kelvin/.face"
    }

    Column {
      anchors.left: logo.right
      anchors.top: logo.top
      anchors.leftMargin: 8
      StyledText {
        text: `<font color="#a6d189">wm: </font>` + "niri"
      }
      StyledText {
        text: `<font color="#ca9ee6">os: </font>` + root.os.slice(0, 11)
      }
      StyledText {
        text: `<font color="#e5c890">host: </font>` + "framework 12"
      }
      StyledText {
        text: `<font color="#8caaee">up: </font>` + root.uptime
      }
    }

    RowLayout {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottomMargin: 10

      Shape {
        shape: MaterialShape.Gem
        color: "#a6d189"
      }
      Shape {
        shape: MaterialShape.Pentagon
        color: "#ca9ee6"
      }
      Shape {
        shape: MaterialShape.Ghostish
        color: "#8caaee"
      }
      Shape {
        shape: MaterialShape.Arrow
        color: "#e5c890"
      }
    }

    component Shape: Item {
      property alias color: mshape.color
      property alias shape: mshape.shape
      height: 25
      Layout.fillWidth: true
      MaterialShape {
        anchors.centerIn: parent
        id: mshape
        width: 25
        height: 25
      }
    }
  }

  FileView {
    id: uptime_file
    path: "/proc/uptime"
    onLoaded: {
      const seconds = Math.floor(parseFloat(text().split(" ")[0]))
      uptime = formatUptime(seconds)
    }
  }

  Process {
    running: true
    command: [ "sh", "-c", `grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"'`]
    stdout: StdioCollector {
      onStreamFinished: os = text
    }
  }

  function formatUptime(seconds) {
    const hours = Math.floor((seconds % 86400) / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)

    return `${hours} hours ${minutes} mins`
  }
}
