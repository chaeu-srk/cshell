import QtQuick
import QtQuick.Layouts
import Quickshell.WindowManager
import M3Shapes

Item {
  id: root
  property real mariginLR: 14
  width: parent.width - mariginLR
  implicitHeight: workspaces.implicitHeight

  property int wsCount: WindowManager.windowsets.length

  Rectangle {
    id: workspaces
    anchors.centerIn: parent
    width: parent.width
    implicitHeight: child.implicitHeight + 20
    color: "#1e1e2e"
    radius: width / 2

    Item {
      id: child
      implicitHeight: wsCount * width
      anchors.centerIn: parent
      width: parent.width

      Repeater {
        model: WindowManager.windowsets
        Item {
          required property var modelData
          width: root.width
          height: width
          y: height * modelData.coordinates[1]

          MaterialShape {
            anchors.centerIn: parent
            shape: modelData.active ? MaterialShape.Diamond : MaterialShape.ClamShell
            implicitSize: modelData.active ? 20 : 18
            color: {
              if (modelData.active) {
                return "#f38ba8"
              } else if (modelData.coordinates[1] === WindowManager.windowsets.length - 1) {
                return "#585b70"
              }
              return "#b4befe"
            }

            Behavior on color {
              ColorAnimation { duration: 200 }
            }
          }
          MouseArea {
            anchors.fill: parent
            onClicked: modelData.activate()
          }

        }
      }
    }

    Behavior on implicitHeight {
      NumberAnimation {
        duration: 200
        easing.type: Easing.OutCubic
      }
    }
  }
}
