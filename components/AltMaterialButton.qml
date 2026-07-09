import QtQuick
import qs.components
import M3Shapes
import Quickshell.Io

Item {
  width: 60
  height: 60
  property var baseShape: MaterialShape.Square
  property alias bgColor: bgShape.color

  property alias icon: icon.icon
  property alias iconColor: icon.color

  MaterialShape {
    id: bgShape
    implicitSize: parent.height
    shape: baseShape
    color: "#414559"
  }

  Icon {
    anchors.centerIn: parent
    textSize: 24
    id: icon
  }

  Timer {
    id: timer
    interval: 500
    onTriggered: {
      bgShape.shape = baseShape
    }
  }

  function click(shape) {
    bgShape.shape = shape
    timer.restart()
  }
}
