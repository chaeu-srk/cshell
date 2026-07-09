import Quickshell
import QtQuick
import qs.components

Item {
  implicitHeight: hour.implicitHeight + minute.implicitHeight
  implicitWidth: hour.implicitWidth

  StyledText {
    id: hour
    text: Qt.formatDateTime(clock.date, "hh ap").slice(0, 2)
    anchors.top: parent.top
  }

  StyledText {
    id: minute
    text: Qt.formatDateTime(clock.date, "mm")
    anchors.bottom: parent.bottom
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
