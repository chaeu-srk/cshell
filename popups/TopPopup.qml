import QtQuick
import QtQuick.Effects
import qs.config

PopupBase {
  id: root
  bottomLeftRadius: 30
  bottomRightRadius: 30

  expandWidth: 1000
  expandHeight: 600

  Corn {
    flip: true
    anchors.left: parent.right
  }
  Corn {
    anchors.right: parent.left
  }

  component Corn : Corners {
    width: 60
    y: root.expand ? Tokens.borderSize : 
    (parent.height <= 40) ? -height : Tokens.borderSize
  }

  Loader {
    // active: parent.height >= 300
    active: root.expand
    anchors.fill: parent
    sourceComponent: Component {
      DashBoard { }
    }
  }


  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true
    onEntered: expand = true;
    onExited: expand = false;
    z: -1
  }
}
