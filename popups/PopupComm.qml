pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property bool blExpand: false
  property real blExpandWidth: 0;
  property real blExpandHeight: 0;

  function showBL(w, h) {
    blExpandWidth = w
    blExpandHeight = h
    blExpand = true
  }

  function hideBL() {
    blComponent = null
    blExpandWidth = 0
    blExpandHeight = 0
    blExpand = false
  }

  property Component blComponent

  property bool rExpand: false
}
