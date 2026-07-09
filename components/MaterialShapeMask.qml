import QtQuick
import QtQuick.Effects
import M3Shapes

Item {
  id: root
  implicitHeight: 80
  implicitWidth: 80

  property alias source: img.source
  property alias shape: mask.shape

  Image {
    id: img
    anchors.fill: parent
    visible: false
  }

  MaterialShape {
    id: mask
    shape: MaterialShape.ClamShell
    anchors.fill: parent

    layer.enabled: true
  }

  MultiEffect {
    anchors.fill: parent
    source: img
    maskSource: mask
    maskEnabled: true
    maskThresholdMin: 0.5
    maskSpreadAtMin: 1
  }
}

