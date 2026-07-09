import Quickshell
import QtQuick

import qs.config

Scope {
  ExclusionZone {
    anchors.left: true
    exclusiveZone: Tokens.barSize - Tokens.borderSize / 2
  }
  ExclusionZone {
    anchors.top: true
  }
  ExclusionZone {
    anchors.right: true
  }
  ExclusionZone {
    anchors.bottom: true
  }
  component ExclusionZone: PanelWindow {
    mask: Region {}
    exclusiveZone: Tokens.borderSize / 2
    updatesEnabled: true
    color: "transparent"
    implicitWidth: 1
    implicitHeight: 1
  }
}
