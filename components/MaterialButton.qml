import QtQuick
import qs.components
import M3Shapes
import Quickshell.Io

Item {
  id: root
  width: 60
  height: 60
  property alias icon: icon.icon
  property int count: 0
  property var shapes: [
    MaterialShape.Square,
    MaterialShape.Cookie4Sided,
    MaterialShape.ClamShell,
    MaterialShape.Gem,
    MaterialShape.Sunny,
  ]
  property alias command: proc.command
  property alias color: icon.color
  property alias shapeColor: bgShape.color

  MaterialShape {
    id: bgShape
    implicitSize: parent.height
    shape: root.shapes[root.count]
    color: "#414559"
  }

  Icon {
    textSize: 28
    anchors.centerIn: parent
    id: icon
  }


  MouseArea {
    anchors.fill: parent
    onClicked: {
      if (timer.running) {
        count = 0
        timer.stop()
      } else {
        count++;
        timer.start()
      }
    }
  }

  Timer {
    id: timer
    interval: 800
    repeat: true
    running: false
    onTriggered: root.tick()
  }

  function tick() {
    if (count >= 4) {
      proc.running = true
      count = 0
      timer.stop()
      return
    }
    count++
  }

  Process {
    id: proc
    command: [ "echo", "empty" ]
  }
}
