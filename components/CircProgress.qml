import Quickshell
import QtQuick

Canvas {
    id: indicator

    property real value: 0.7
    property real thickness: 8
    property real gapDegrees: 8
    property color remainderColor: "#626880"
    property color progressColor: root.circColor

    width: 80
    height: 80

    Behavior on value {
      NumberAnimation { duration: 200 }
    }

    onPaint: {
      const ctx = getContext("2d")
      ctx.reset()
      const cx = width / 2
      const cy = height / 2
      const r = width / 2 - thickness

      ctx.lineWidth = thickness
      ctx.lineCap = "round"
      const gap = 12 * Math.PI / 180
      const start = -Math.PI / 2
      const end = start + value * Math.PI * 2

      // Progress segment
      ctx.beginPath()
      ctx.strokeStyle = progressColor
      ctx.arc(cx, cy, r,
        start + gap,
        end - gap,
      )
      ctx.stroke()

      // Remaining segment
      ctx.beginPath()
      ctx.strokeStyle = remainderColor
      ctx.arc(cx, cy, r,
        end + gap,
        Math.PI * 3 / 2 - gap
      )
      ctx.stroke()
    }
    onValueChanged: requestPaint()
  }

