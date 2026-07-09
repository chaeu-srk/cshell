import QtQuick
import qs.config

PopupBase {
  id: root

  topRightRadius: 30

  anchors.bottom: parent.bottom
  anchors.left: parent.left
  anchors.leftMargin: Tokens.barSize
  anchors.bottomMargin: Tokens.borderSize

  baseWidth: 0
  baseHeight: 20

  expandHeight: PopupComm.blExpandHeight
  expandWidth: PopupComm.blExpandWidth
  expand: PopupComm.blExpand

  Behavior on implicitHeight {
    SpringAnimation { spring: 3; damping: 0.3 }
  }

  Behavior on implicitWidth {
    SpringAnimation { spring: 3; damping: 0.3 }
  }

  Corners {
    flip: true
    flipH: true

    anchors.bottom: parent.top
    x: root.expand ? 0 : (parent.width <= 40) ? -height : 0
  }

  Corners {
    anchors.left: parent.right
    anchors.bottom: parent.bottom

    flip: true
    flipH: true
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onExited: PopupComm.hideBL()
  }

  Loader {
    // active: root.expand && parent.width >= 300
    anchors.fill: parent
    // anchors.right: parent.right
    // anchors.left: parent.left
    // width: parent.width
    // height: parent.height
    sourceComponent: PopupComm.blComponent
  }
}
