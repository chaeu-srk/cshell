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
    font.family: "Symbols Nerd Font"
    font.pixelSize: 20
    color: Tokens.text
  }
}
