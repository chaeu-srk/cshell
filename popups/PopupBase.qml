import QtQuick
import qs.config

Item {
  id: root
  property bool expand: false;
  required property real expandWidth;
  required property real expandHeight;
  property real baseWidth: expandWidth - 100;
  property real baseHeight: Tokens.borderSize;

  property alias bottomRightRadius: bg.bottomRightRadius
  property alias bottomLeftRadius: bg.bottomLeftRadius
  property alias topRightRadius: bg.topRightRadius
  property alias topLeftRadius: bg.topLeftRadius

  implicitHeight: expand ? expandHeight : baseHeight;
  implicitWidth: expand ? expandWidth : baseWidth;

  Rectangle {
    id: bg
    anchors.fill: parent
    color: Tokens.bg
  }

  Behavior on implicitHeight {
    SpringAnimation { spring: 3; damping: 0.3 }
  }

  Behavior on implicitWidth {
    SpringAnimation { spring: 3; damping: 0.3 }
  }

}
