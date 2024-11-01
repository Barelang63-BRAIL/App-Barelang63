import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.15
import "stm"
import "../control"

Rectangle {
    id: rect
    color: "transparent"
    onVisibleChanged: {
        if (visible)
            joyTimer.start()
        else
            joyTimer.stop()
    }

    Timer {
        id: joyTimer
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var linX = 0
            var linY = 0
            if (linJoy.visible) {
                linX = linJoy.controllerYPosition
                linY = -linJoy.controllerXPosition
            } else if (joyButton.visible) {
                if (joyButton.state == "forward")
                    linX = 1
                else if (joyButton.state == "backward")
                    linX = -1
                else if (joyButton.state == "left")
                    linY = 1
                else if (joyButton.state == "right")
                    linY = -1
            }

            stmProcessObject.setInput_x((linX * linSlider.value).toFixed(2))
            stmProcessObject.setInput_y((linY * linSlider.value).toFixed(2))
            stmProcessObject.setInput_a(
                        (-angJoy.controllerXPosition * aSlider.value).toFixed(
                            3))
        }
    }

    OmniWheel {
        id: omniWheel
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        w1: stmProcessObject.wheel1
        w2: stmProcessObject.wheel2
        w3: stmProcessObject.wheel3
    }
    Switch {
        id: controlSwitch
        width: 40
        height: 15

        anchors.bottom: linJoy.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: linJoy.horizontalCenter

        indicator: Rectangle {
            implicitWidth: 35
            implicitHeight: 15
            y: parent.height / 2 - height / 2
            radius: 13
            color: controlSwitch.checked ? "cyan" : "#d745cf"
            border.color: controlSwitch.checked ? "#17a81a" : "#cccccc"

            Rectangle {
                x: controlSwitch.checked ? parent.width - width : 0
                width: 15
                height: width
                radius: width / 2
                color: controlSwitch.down ? "#cccccc" : "#ffffff"
                border.color: controlSwitch.checked ? (controlSwitch.down ? "#17a81a" : "#21be2b") : "#999999"
            }
        }

        contentItem: Text {
            text: controlSwitch.text
            font: controlSwitch.font
            opacity: enabled ? 1.0 : 0.3
            color: controlSwitch.down ? "#17a81a" : "#21be2b"
            verticalAlignment: Text.AlignVCenter
            //leftPadding: control.indicator.width + control.spacing
        }
    }

    StmPosition {
        id: stmPosition
        width: 100
        height: 100
        anchors.left: omniWheel.right
        anchors.verticalCenter: omniWheel.verticalCenter
        x_val: stmProcessObject.x_pos
        y_val: stmProcessObject.y_pos
        a_val: stmProcessObject.a_pos
    }

    JoystickControllerHUD {
        id: linJoy
        visible: controlSwitch.checked
        backgroundImageSource: "../img/joySrc.png"
        thumbSource: "../img/thumSrc.png"
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 100
        joystickRadius: 150 / 2
        thumbRadius: 30
    }
    JoyButtonComp {
        id: joyButton
        width: linJoy.width
        height: linJoy.height
        anchors.centerIn: linJoy
        visible: !controlSwitch.checked
    }
    JoystickControllerHUD {
        id: angJoy

        backgroundImageSource: "../img/joySrc.png"
        thumbSource: "../img/thumSrc.png"
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 100
        joystickRadius: 150 / 2
        thumbRadius: 30
    }
    Connections {
        target: startButton
        onIndexChanged: {
            linJoy.controllerXPosition = 0
            linJoy.controllerYPosition = 0
            angJoy.controllerXPosition = 0
            angJoy.controllerYPosition = 0
        }
    }

    SliderCustom {
        id: aSlider
        width: 150
        height: 10
        anchors.bottom: aTextLabel.bottom
        anchors.bottomMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 20
        onValueChanged: aText.text = value.toFixed(2)
    }
    AppText {
        id: aTextLabel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: aSlider.horizontalCenter
        fontSize: 6
        color: "cyan"
        text: "angularMax"
    }
    AppText {
        id: aText
        anchors.left: aSlider.right
        anchors.verticalCenter: aSlider.verticalCenter
        fontSize: 6
        color: "cyan"
    }

    SliderCustom {
        id: linSlider
        from: 0
        to: 2
        width: 150
        height: 10
        anchors.bottom: linTextLabel.bottom
        anchors.bottomMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 20
        onValueChanged: linText.text = value.toFixed(2)
    }
    AppText {
        id: linTextLabel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: linSlider.horizontalCenter
        fontSize: 6
        color: "cyan"
        text: "linearMax"
    }
    AppText {
        id: linText
        anchors.right: linSlider.left
        anchors.verticalCenter: linSlider.verticalCenter
        fontSize: 6
        color: "cyan"
    }

    //    GameSlider{
    //        anchors.bottom: parent.bottom
    //        width: 200
    //    }
}
