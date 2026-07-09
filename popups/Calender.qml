import QtQuick
import QtQuick.Layouts
import M3Shapes
import qs.components
import qs.services

Item {
  id: root
  anchors.fill: parent

  property var today: new Date()
  property int month: today.getMonth()
  property int year: today.getFullYear()
  property var calendarModel: generateCalendarModel(year, month)

  function generateCalendarModel(year, month) {
    var days = [];

    // Day-of-week of the 1st, remapped so Monday = 0 ... Sunday = 6
    var firstOfMonth = new Date(year, month, 1);
    var firstDayIndex = (firstOfMonth.getDay() + 6) % 7;

    var daysInMonth = new Date(year, month + 1, 0).getDate();     // last day of current month
    var daysInPrevMonth = new Date(year, month, 0).getDate();     // last day of previous month

    // --- Leading days: tail end of the previous month ---
    for (var i = firstDayIndex - 1; i >= 0; i--) {
      days.push({
        day: daysInPrevMonth - i,
        month: (month - 1 + 12) % 12,
        year: month === 0 ? year - 1 : year,
        isCurrentMonth: false
      });
    }

    // --- Current month days ---
    for (var d = 1; d <= daysInMonth; d++) {
      days.push({
        day: d,
        month: month,
        year: year,
        isCurrentMonth: true
      });
    }

    // --- Trailing days: start of next month, to reach 42 cells ---
    var remaining = 42 - days.length;
    for (var n = 1; n <= remaining; n++) {
      days.push({
        day: n,
        month: (month + 1) % 12,
        year: month === 11 ? year + 1 : year,
        isCurrentMonth: false
      });
    }

    return days;
  }

  RowLayout {
    id: days
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: dates.top
    anchors.bottomMargin: 15
    spacing: 24

    Repeater {
      model: [
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Sun"
      ]
      Item {
        width: 25; height: 25;
        required property string modelData

        StyledText {
          anchors.centerIn: parent
          text: modelData
          font.pointSize: 15
        }
      }
    }
  }

  GridLayout {
    id: dates
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.margins: 20
    columns: 7
    columnSpacing: 10
    rowSpacing: 0

    Repeater {
      model: root.calendarModel
      Item {
        width: 40; height: 40;
        required property int index
        required property var modelData
        property bool isToday: {
          let date = new Date()
          modelData.isCurrentMonth
          && modelData.day === date.getDate()
          && modelData.month === date.getMonth()
          && modelData.year === date.getFullYear()
        }

        Loader {
          active: isToday
          anchors.fill: parent
          sourceComponent: Component {
            MaterialShape {
              anchors.centerIn: parent
              implicitSize: 31
              shape: MaterialShape.ClamShell
              color: "#89b4fa"
            }
          }
        }

        StyledText {
          text: modelData.day
          anchors.centerIn: parent
          font.bold: isToday
          font.pointSize: 15
          color: modelData.isCurrentMonth ?
          (isToday ? "#11111b" : "#cdd6f4") : "#45475a"
        }

      }
    }
  }

  StyledText {
    id: header
    text: Qt.formatDate(today, "MMMM yyyy")
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: days.top
    anchors.bottomMargin: 15
    font.pointSize: 22
  }


  // Icon {
  //   icon: ""
  //   anchors.right: days.right
  //   anchors.bottom: days.top
  //   anchors.verticalCenter: header.verticalCenter
  //   anchors.bottomMargin: 15
  //   MouseArea {
  //     anchors.fill: parent
  //     onClicked: {
  //       console.log("next year")
  //       if ((root.month + 1) > 11) {
  //         today.setFullYear(year + 1)
  //         today.setMonth(0)
  //       }
  //       today.setMonth(root.month + 1)
  //     }
  //   }
  // }
  //
  // Icon {
  //   icon: ""
  //   anchors.left: days.left
  //   anchors.bottom: days.top
  //   anchors.verticalCenter: header.verticalCenter
  //   anchors.bottomMargin: 15
  //   MouseArea {
  //     anchors.fill: parent
  //     onClicked: {
  //       console.log("prev year")
  //       if ((root.month - 1) > 0) {
  //         today.setFullYear(year - 1)
  //         today.setMonth(11)
  //       }
  //       today.setMonth(root.month - 1)
  //     }
  //   }
  // }
}
