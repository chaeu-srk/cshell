import Quickshell.Services.Notifications
import QtQuick
import qs.components

TopRightPopup {
  id: root


  Loader {
    id: loader
    active: false
    anchors.fill: parent
    property string body
    property string summary
    property string app
    sourceComponent: notificationComp
  }

  Component {
    id: notificationComp
    Item {
      id: noti
      anchors.fill: parent
      anchors.margins: 15
      StyledText {
        font.pointSize: 18
        id: sumText
        text: summary
      }
      StyledText {
        id: appText
        anchors.left: sumText.right
        // anchors.bottom: sumText.bottom
        anchors.leftMargin: 10
        font.pointSize: 18
        text: app
        color: "#a6adc8"
      }
      StyledText {
        id: bodText
        anchors.top: sumText.bottom
        text: body
        font.pointSize: 14
      }
    }
  }

  NotificationServer {
    onNotification: (notification) => {
      loader.active = true
      loader.body = notification.body
      loader.summary = notification.summary
      loader.app = notification.appName
      root.expand = true
      timer.restart()
    }
  }

  Timer {
    id: timer
    interval: 5000
    onTriggered: {
      root.expand = false
      loader.active = false
    }
  }
}
