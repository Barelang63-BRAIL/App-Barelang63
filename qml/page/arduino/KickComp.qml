import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
import "../../control"

Rectangle {
    color: "transparent"
    width: 300
    height: 300

    CheckBoxCustom {
        id: onoff
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        width: 25
        height: width
        checked: false
        onCheckedChanged: {
            kickSlider.enabled = false
            kickBtn.enabled = false
            kickBtn.opacity = 0.5
            if (checked) {
                kickSlider.enabled = true
                kickBtn.enabled = true
                kickBtn.opacity = 1
            }
        }
    }
    AppText {
        text: "On/Off"
        color: "cyan"
        anchors.bottom: onoff.top
        anchors.horizontalCenter: onoff.horizontalCenter
        fontSize: 5
    }

    SliderCustomVertical {
        id: kickSlider
        height: 150 * parent.height / 300
        width: 10
        from: 0
        to: 255
        value: 0
        stepSize: 1
        anchors.left: onoff.right
        anchors.leftMargin: 50
        enabled: false
        anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
        id: txtKick
        text: kickSlider.value
        anchors.left: kickSlider.right
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        color: "cyan"
        fontSize: 10
    }

    StartButton {
        id: kickBtn
        width: 100 * parent.width / 300
        height: width
        enabled: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 30
        opacity: 0.5
        AppText {
            text: "Kick"
            anchors.centerIn: parent
            color: "cyan"
        }
        onOnoffChanged: {
            scale = kickBtn.onoff ? 1.1 : 1
            if (kickBtn.onoff) {
                kickTimer.start()
            } else {
                kickTimer.stop()
                arduinoProcessObject.setKick(highKick.checked, 0)
            }
        }
    }

    Timer {
        id: kickTimer
        interval: 30
        onTriggered: {
            arduinoProcessObject.setKick(highKick.checked, kickSlider.value)
        }

        running: false
        repeat: true
        triggeredOnStart: false
    }
    RadioButtonCustom {
        id: highKick
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -30
        anchors.right: kickBtn.left
        anchors.rightMargin: 50
        checked: false
    }
    AppText {
        text: "high"
        anchors.bottom: highKick.top
        anchors.bottomMargin: 10
        anchors.horizontalCenter: highKick.horizontalCenter
        fontSize: 5
        color: "cyan"
    }

    RadioButtonCustom {
        id: lowKick
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 30
        anchors.horizontalCenter: highKick.horizontalCenter
        checked: true
    }
}
