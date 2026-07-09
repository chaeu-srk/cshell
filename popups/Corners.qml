pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import qs.config

Item {
  id: root
  property bool flip: false;
  property bool flipH: false;

  width: 50
  height: width

  Behavior on y {
    NumberAnimation {
      duration: 50
    }
  }

  Behavior on x {
    NumberAnimation {
      duration: 50
    }
  }

  Rectangle {
    anchors.right: root.flip ? undefined : parent.right
    anchors.left: root.flip ? parent.left : undefined
    anchors.top: root.flipH ? undefined : parent.top
    anchors.bottom: root.flipH ? parent.bottom : undefined
    color: Tokens.bg

    implicitWidth: parent.width / 2
    implicitHeight: parent.height / 2
  }

  layer.enabled: true
  layer.effect: MultiEffect {
    maskSource: mask
    maskEnabled: true
    maskInverted: true
    maskThresholdMin: 0.5
    maskSpreadAtMin: 1
  }

  Item {
    id: mask
    anchors.fill: parent
    layer.enabled: true
    visible: false

    Rectangle {
      id: maskInner
      anchors.fill: parent
      radius: 100
    }
  }
}
