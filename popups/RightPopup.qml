import QtQuick
import qs.services
import qs.config
import qs.components

PopupBase {
  anchors.right: parent.right
  anchors.rightMargin: Tokens.borderSize
  anchors.verticalCenter: parent.verticalCenter

  topLeftRadius: 30
  bottomLeftRadius: 30

  baseHeight: 400
  baseWidth: 0
  expandHeight: 600
  expandWidth: 60

  Connections {
    target: System
    function onVolumeChanged() {
      expand = true
      timer.restart()
    }
    function onMutedChanged() {
      expand = true
      timer.restart()
    }
    function onBrightnessPercentChanged() {
      expand = true
      timer.restart()
    }
  }

  Loader {
    active: expand
    anchors.fill: parent
    sourceComponent: sliders
  }
  
  Component {
    id: sliders

    Item {
      anchors.fill: parent

      Slider {
        id: volSlider
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        progress: System.volume >= 1 ? 1 : System.volume
        color: System.volume > 1.1 ? "#f38ba8" : "#b4befe"
      }
      Icon {
        icon: ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: brtSlider.bottom
        anchors.topMargin: 10
        color: "#f9e2af"
      }

      Icon {
        icon: System.muted ? "" : ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: volSlider.top
        anchors.bottomMargin: 10
        color: "#b4befe"
      }

      Slider {
        id: brtSlider
        anchors.top: parent.top
        anchors.topMargin: 25
        progress: System.brightnessPercent / 100
        color: "#f9e2af"
      }

      component Slider: Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 20
        height: parent.height / 2 - 80
        property real progress: 0.4;
        property alias color: a.color

        Rectangle {
          anchors.top: parent.top
          width: parent.width
          height: parent.height * (1 - progress) - 4
          radius: 5
          color: "#313244"
        }

        Rectangle {
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: a.top
          anchors.bottomMargin: 3
          width: parent.width + 10
          height: 2
          radius: height / 2
        }

        Rectangle {
          id: a
          anchors.bottom: parent.bottom
          width: parent.width
          height: parent.height * progress - 4
          radius: 5
        }

        Behavior on progress {
          NumberAnimation { duration: 150; }
        }
      }
    }
  }

  Timer {
    id: timer
    interval: 2000
    onTriggered: expand = false
  }

  Corners {
    anchors.bottom: parent.top
    flipH: true
    x: 10
  }

  Corners {
    anchors.top: parent.bottom
    x: 10
  }
}
