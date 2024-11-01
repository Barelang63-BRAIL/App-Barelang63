import QtQuick 2.0
import Felgo 3.0
import QtCharts 2.3
import "../../control"

Rectangle {
    width: 200
    height: 200
    color: "transparent"

    AppButton {
        id: onoff
        property bool on: false
        text: "Dribbler"
        anchors.centerIn: parent
        backgroundColor: "gray"
        radius: 5
        minimumHeight: 50
        minimumWidth: 150
        onOnChanged: {
            arduinoProcessObject.setDribblerOnOff(onoff.on)
            if (on) {
                backgroundColor = "cyan"
                leftSlider.enabled = true
                rightSlider.enabled = true
            } else {
                backgroundColor = "gray"
                leftSlider.enabled = false
                rightSlider.enabled = false
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.on = !parent.on
            }
        }
    }

    SliderCustomVertical {
        id: leftSlider
        height: 150 * parent.height / 300
        width: 10
        from: -255
        to: 255
        value: 0
        enabled: false
        stepSize: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -250
        onValueChanged: arduinoProcessObject.setLeftDribbler(leftSlider.value)
    }
    AppText {
        id: txtLeft
        text: leftSlider.value
        anchors.right: leftSlider.left
        anchors.rightMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        color: "cyan"
        fontSize: 10
    }
    AppButton {
        id: leftReset
        text: "reset"
        textSize: 15
        anchors.top: leftSlider.bottom
        anchors.horizontalCenter: leftSlider.horizontalCenter
        backgroundColor: "#d745cf"
        backgroundColorPressed: "#d745cf"
        minimumHeight: 20
        minimumWidth: 50
        radius: 5
        horizontalPadding: 0
        verticalPadding: 0
        onClicked: leftSlider.value = 0
    }
    AppButton {
        id: rightReset
        text: "reset"
        textSize: 15
        anchors.top: rightSlider.bottom
        anchors.horizontalCenter: rightSlider.horizontalCenter
        backgroundColor: "#d745cf"
        backgroundColorPressed: "#d745cf"
        minimumHeight: 20
        minimumWidth: 50
        radius: 5
        horizontalPadding: 0
        verticalPadding: 0
        onClicked: rightSlider.value = 0
    }

    SliderCustomVertical {
        id: rightSlider
        height: 150 * parent.height / 300
        width: 10
        from: -255
        to: 255
        value: 0
        enabled: false
        stepSize: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 250
        onValueChanged: arduinoProcessObject.setRightDribbler(rightSlider.value)
    }
    AppText {
        id: txtRight
        text: rightSlider.value
        anchors.left: rightSlider.right
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        color: "cyan"
        fontSize: 10
    }
}
