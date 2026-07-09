import QtQuick
import qs.config

Item {
  id: root
  property alias icon: text.text
  property alias textSize: text.font.pixelSize
  property alias color: text.color
  property real size: 24

  width: size
  height: size

  Text {
    anchors.centerIn: parent

    id: text
    font.family: "Material Symbols Outlined"
    font.pixelSize: 18
    color: Tokens.text
  }
}

