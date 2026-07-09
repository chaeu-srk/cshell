import QtQuick
import M3Shapes
import qs.services
import qs.components

  Rectangle {
    id: root
    anchors.right: parent.right
    anchors.top: topBar.bottom
    anchors.bottom: parent.bottom
    anchors.leftMargin: 10

    width: 300
    radius: 20
    color: "#181825"

    property var music: System.get_player()

    StyledText {
      id: trackTitle
      text: System.truncate(root.music?.trackTitle, 16) || "No media"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: trackImg.bottom
      anchors.topMargin: 20
      font.pointSize: 18

      // width: parent.width - 30
      horizontalAlignment: Text.AlighHCenter
    }

    SText {
      id: trackAlbum
      anchors.top: trackTitle.bottom
      text: System.truncate(root.music?.trackAlbum, 16) || "..."
      color: "#6c7086"
    }

    SText {
      id: trackArtist
      anchors.top: trackAlbum.bottom
      text: System.truncate(root.music?.trackArtist, 16) || "..."
    }

    component SText : StyledText {
      elide: Text.ElideRight
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlighHCenter
      font.pointSize: 14
    }

    Item {
      id: trackImg
      // anchors.left: parent.left
      // anchors.right: parent.right
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.margins: 30
      width: 160
      height: width

      Loader {
        id: loader
        anchors.fill: parent
        property var trackArtUrl: root.music?.trackArtUrl
        property var isPlaying: root.music?.isPlaying
        sourceComponent:
        !player ? fallback : trackArtUrl ? mediaIcon : fallback
      }

      Component {
        id: fallback
        MaterialShape {
          shape: isPlaying ? MaterialShape.Sunny : MaterialShape.Square 
          anchors.fill: parent
          color: "#45475a"
          StyledText {
            text: "( ._.) "
            font.family: "Noto Sans NerdFont"
            font.pointSize: 24
            anchors.centerIn: parent
          }
        }
      }

      Component {
        id: mediaIcon
        MaterialShapeMask {
          shape: isPlaying ? MaterialShape.Sunny : MaterialShape.Square
          anchors.fill: parent
          source: trackArtUrl
        }
      }
    }

    Item {
      anchors.top: trackArtist.bottom
      anchors.bottom: parent.bottom
      width: parent.width

      Rectangle {
        id: playpause
        anchors.centerIn: parent

        width: 100
        height: 50
        radius: 15

        color: "#b4befe"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            if (root.music) {
              root.music.isPlaying = !root.music.isPlaying
            }
          }
        }

        Icon {
          anchors.centerIn: parent
          icon: root.music?.isPlaying ? "" : ""
          color: "#11111b"
        }

      }

      Rectangle {
        id: left
        anchors.top: playpause.top
        anchors.right: playpause.left
        height: playpause.height
        anchors.rightMargin: 8
        radius: 10

        bottomLeftRadius: 25
        topLeftRadius: 25

        width: 65
        color: "#313244"

        Icon {
          anchors.centerIn: parent
          icon: "󰒮"
          textSize: 25
        }
      }

      Rectangle {
        id: right
        anchors.top: playpause.top
        anchors.left: playpause.right
        anchors.leftMargin: 8
        height: playpause.height
        radius: 10

        topRightRadius: 25
        bottomRightRadius: 25

        width: 65
        color: "#313244"

        Icon {
          anchors.centerIn: parent
          icon: "󰒭"
          textSize: 25
        }
      }
    }
  }
