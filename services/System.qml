pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Services.Notifications
import Quickshell.Services.Mpris
import QtQuick

Singleton {
  id: root
  // AUDIO
  property var sink: Pipewire.defaultAudioSink
  property real volume: sink.audio.volume
  property bool muted: sink.audio.muted
  PwObjectTracker {
    objects: [root.sink]
  }

  // PLAYER
  function get_player() {
    if (Mpris.players.values.length < 1) {
      // console.log("no player")
      return null
    }
    for (let i = 0; Mpris.players.values.length; i++) {
      // console.log("player found")
      // console.log(JSON.stringify(Mpris.players.values[i]))
      return Mpris.players.values[i]
    }
  }

  // BRIGHTNESS
  property int brightness: 0
  property int maxBrightness: 0
  property int brightnessPercent: Math.floor(brightness / maxBrightness * 100)
  FileView {
    path: "/sys/class/backlight/intel_backlight/brightness"
    watchChanges: true
    onFileChanged: {
      reload()
      root.brightness = parseInt(text())
    }
    onLoaded: root.brightness = parseInt(text())
  }
  FileView {
    path: "/sys/class/backlight/intel_backlight/max_brightness"
    onLoaded: root.maxBrightness = parseInt(text())
  }
  // BATTERY
  property UPowerDevice device: UPower.displayDevice
  property bool isPowerSaver: PowerProfiles.profile === PowerProfile.PowerSaver
  property bool isBalanced: PowerProfiles.profile === PowerProfile.Balanced
  property bool isPerformance: PowerProfiles.profile === PowerProfile.Performance

  function set_power_profile(prof) {
    switch (prof) {
      case 1: PowerProfiles.profile = PowerProfile.PowerSaver
      break
      case 2: PowerProfiles.profile = PowerProfile.Balanced
      break
      case 3: PowerProfiles.profile = PowerProfile.Performance
      break
    }
  }

  property bool charging: device.state === UPowerDeviceState.Charging
  property real batteryFloat: device.percentage
  property int batteryPercent: Math.floor(device.percentage * 100)
  property string batteryIcon: {
    if (charging) {
      return ""
    } else if (batteryPercent < 25) {
      return "󰁻"
    } else if (batteryPercent < 50) {
      return "󰁾"
    } else if (batteryPercent < 75) {
      return "󰂀"
    }
    return "󰁹"
  }

  // CLOCK
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
  property string time: Qt.formatDateTime(clock.date, "hh:mm AP")
  property string date: Qt.formatDateTime(clock.date, "dddd dd MMM")
  property string monthYear: Qt.formatDateTime(clock.date, "MMMM yyyy")

  // CPU
  property var previous: null
  property real cpuUsage: 0
  property real cpuTemp: 0

  FileView {
    id: cpuReader
    path: "/proc/stat"
    onLoaded: {
      updateUsage(text())
    }
  }

  // FileView {
  //   id: cpuTempReader
  //   path: "/sys/class/hwmon/hwmon6/temp1_input"
  //   onLoaded: {
  //     cpuTemp = parseFloat(text()) / 1000
  //   }
  // }

  Timer {
    id: cpuTimer
    interval: 2000
    repeat: true
    running: true
    onTriggered: {
      // cpuTempReader.reload()
      cpuReader.reload()
    }
  }

  function parseStat(text) {
    const firstLine = text.split("\n")[0];
    const values = firstLine
      .trim()
      .split(/\s+/)
      .slice(1)
      .map(Number);
    const idle = values[3] + values[4];
    const nonIdle =
      values[0] +
      values[1] +
      values[2] +
      values[5] +
      values[6] +
      values[7];
    return {
      idle: idle,
      total: idle + nonIdle
    };
  }

  function updateUsage(text) {
    const current = parseStat(text);
    if (previous !== null) {
      const totalDiff = current.total - previous.total;
      const idleDiff = current.idle - previous.idle;
      cpuUsage = (totalDiff - idleDiff) / totalDiff;
    }
    previous = current;
  }

  // MEMORY
  property real memoryUsage: 0
  Process {
    id: memReader
    running: true
    command: [
      "awk",
      "/MemTotal:/ {total=$2} /MemAvailable:/ {avail=$2} END { printf \"%.3f\\n\", (total-avail)/total }",
      "/proc/meminfo"
    ]
    stdout: StdioCollector {
      onStreamFinished: memoryUsage = parseFloat(text)
    }
  }

  Timer {
    id: memTimer
    interval: 300
    running: true
    repeat: true
    onTriggered: memReader.running = true
  }

  function truncate(text, num) {
    if (!text) return text
    if (text.length <= num) return text;
    let truncated = text.slice(0, num);
    return truncated + "…"
  }

  // WIFI
  property var nwDevice: Networking.devices.values[0];
  property bool wifiOn: Networking.wifiEnabled;
  property bool wifiConnected: nwDevice.connected;
  property real connStrength: {
    if (!wifiConnected) {
      return 0
    }
    for (const network of nwDevice.networks.values) {
      return network.signalStrength
    }
  }

  function get_current_wifi_strength() {
    for (const network of nwDevice.networks.values) {
      if (network.connected) {
        return network.strength
      }
    }
  }

  function get_current_wifi_name() {
    if (!wifiOn) {
      return "Wifi Off"
    } 
    if (!wifiConnected) {
      return "Not Connected"
    }
    for (const network of nwDevice.networks.values) {
      if (network.connected) {
        return network.name
      }
    }
  }
  property string wifiIcon: {
    if (!wifiOn || !wifiConnected) {
      return "󰤮"
    } else if (!wifiConnected) {
      return "󰤯"
    } else if (connStrength <= 0.3) {
      return "󰤟"
    } else if (connStrength <= 0.6) {
      return "󰤢"
    }
    return "󰤨"
  }

  // BLUETOOTH
  // property var btAdapter: Bluetooth.defaultAdapter
  property bool btOn: Bluetooth.defaultAdapter.enabled

  property string btIcon: btOn ? "󰂯" : "󰂲"
}
