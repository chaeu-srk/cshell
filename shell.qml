import Quickshell
import QtQuick
import qs.config
import qs.popups
import qs.bar

ShellRoot {
  Exclusions { }

  PanelWindow {
    id: root
    anchors {
      left: true
      bottom: true
      right: true
      top: true
    }
    color: "transparent"
    mask: Region {
      item: bar
      Region {
        item: topPopup
      }
      Region {
        item: blPopup
      }
      Region {
        item: trPopup
      }

    }
    exclusionMode: ExclusionMode.Ignore

    Border {
      barSize: Tokens.barSize
      borderSize: Tokens.borderSize
    }

    Bar { id: bar }

    TopPopup {
      id: topPopup
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
    }

    RightPopup {}

    BotLeftPopup { id: blPopup }
    // TopRightPopup { id: trPopup }
    Notification { id: trPopup }
  }
}
