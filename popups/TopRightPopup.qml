import QtQuick
import qs.config

PopupBase {
  anchors.right: parent.right
  anchors.top: parent.top
  anchors.margins: Tokens.borderSize

  baseHeight: 0
  baseWidth: 0
  bottomLeftRadius: 30

  expandHeight: 150
  expandWidth: 500

  expand: false

  Corners {
    visible: parent.height > 0
    anchors.top: parent.bottom
    anchors.right: parent.right
  }

  Corners {
    visible: parent.height > 0
    anchors.top: parent.top
    anchors.right: parent.left
  }
}
