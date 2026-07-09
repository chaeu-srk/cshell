pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string winTitle: ""

  Component.onCompleted: {
    niriWinTitle.running = true
    eventStream.running = true
  }

  Process {
    id: niriWinTitle
    command: ["niri", "msg", "--json", "focused-window"]
    stdout: StdioCollector {
      onStreamFinished: {
        const window = JSON.parse(data)
        if (!window) {
          root.winTitle = ""
        } else {
          root.winTitle = System.truncate(window.title, 30)
        }
      }
    }
  }

  Process {
    id: eventStream
    running: false
    command: ["niri", "msg", "--json", "event-stream"]
    stdout: SplitParser {
      onRead: (data) => {
        try {
          const event = JSON.parse(data)
          if (
            event.WindowFocusChanged !== undefined
            // event.WorkspaceActivated !== undefined
            // event.WindowLayoutsChanged !== undefined ||
            // event.WindowOpenedOrChanged !== undefined
          ) {
            niriWinTitle.running = true
          }

        } catch (e) {
          console.log("failed to parse event:", data)
        }
      }
    }
  }
}
