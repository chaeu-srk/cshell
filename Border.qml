import QtQuick
import QtQuick.Effects
import qs.config

Rectangle {
  property alias borderSize: maskInner.anchors.margins
  property alias barSize: maskInner.anchors.leftMargin

  id: border
  anchors.fill: parent
  color: "#11111b"

  layer.enabled: true
  layer.effect: MultiEffect {
    maskSource: mask
    maskEnabled: true
    maskInverted: true
    maskThresholdMin: 0.5
    maskSpreadAtMin: 1
  }
  z: -1

  Item {
    id: mask
    anchors.fill: parent
    layer.enabled: true
    visible: false

    Rectangle {
      id: maskInner
      anchors.fill: parent
      anchors.margins: 8
      radius: 20
    }

    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 3
      width: 800
      height: Tokens.borderSize + 30
      radius: 30
    }
  }
}

