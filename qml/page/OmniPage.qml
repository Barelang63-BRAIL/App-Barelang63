import QtQuick 2.0
import QtQuick.Controls 2.5
import Felgo 3.0

import "../control"

Rectangle {
    color: "transparent"
    width: 240
    height: 240
    onVisibleChanged: {
        imageTimer.stop()
        if (visible) {
            imageTimer.start()
            omniProcessObject.requestConfig()
            console.log("req")
        }
    }

    Connections {
        target: omniProcessObject
        function onConfigUpdated() {
            greenRangeH.first.value = omniProcessObject.greenHmin
            greenRangeS.first.value = omniProcessObject.greenSmin
            greenRangeV.first.value = omniProcessObject.greenVmin
            greenRangeH.second.value = omniProcessObject.greenHmax
            greenRangeS.second.value = omniProcessObject.greenSmax
            greenRangeV.second.value = omniProcessObject.greenVmax

            orangeRangeH.first.value = omniProcessObject.orangeHmin
            orangeRangeS.first.value = omniProcessObject.orangeSmin
            orangeRangeV.first.value = omniProcessObject.orangeVmin
            orangeRangeH.second.value = omniProcessObject.orangeHmax
            orangeRangeS.second.value = omniProcessObject.orangeSmax
            orangeRangeV.second.value = omniProcessObject.orangeVmax

            whiteRangeH.first.value = omniProcessObject.whiteHmin
            whiteRangeS.first.value = omniProcessObject.whiteSmin
            whiteRangeV.first.value = omniProcessObject.whiteVmin
            whiteRangeH.second.value = omniProcessObject.whiteHmax
            whiteRangeS.second.value = omniProcessObject.whiteSmax
            whiteRangeV.second.value = omniProcessObject.whiteVmax

            yellowRangeH.first.value = omniProcessObject.yellowHmin
            yellowRangeS.first.value = omniProcessObject.yellowSmin
            yellowRangeV.first.value = omniProcessObject.yellowVmin
            yellowRangeH.second.value = omniProcessObject.yellowHmax
            yellowRangeS.second.value = omniProcessObject.yellowSmax
            yellowRangeV.second.value = omniProcessObject.yellowVmax

            blackRangeH.first.value = omniProcessObject.blackHmin
            blackRangeS.first.value = omniProcessObject.blackSmin
            blackRangeV.first.value = omniProcessObject.blackVmin
            blackRangeH.second.value = omniProcessObject.blackHmax
            blackRangeS.second.value = omniProcessObject.blackSmax
            blackRangeV.second.value = omniProcessObject.blackVmax

            brightnessSlider.value = omniProcessObject.brightness
            saturationSlider.value = omniProcessObject.saturation
        }
    }

    Timer {
        id: imageTimer
        running: false
        repeat: true
        interval: 30
        onTriggered: {
            omniViewer.reload()
        }
    }

    Image {
        id: omniViewer
        width: 240
        height: 240
        cache: false
        asynchronous: false
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        property bool counter: false

        function reload() {
            counter = !counter
            source = "image://omni/image?id=" + counter
        }
    }

    Image {
        id: borderImg
        width: 300
        height: 300
        source: "../img/240_240_border.png"
        anchors.centerIn: omniViewer
        Image {
            id: recordButton
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 2
            anchors.bottomMargin: 2
            source: "../img/thumSrc.png"
            width: 30
            height: 30
            Icon {
                id: recordIcon
                icon: IconType.camera
                anchors.fill: parent
                size: 15
                color: "cyan"
            }

            RoundMouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    if (pressed) {
                        confirmButton.mode = 2
                        confirmButton.text = "record"
                        blurNotif.visible = true
                        notifContainer.visible = true
                    }
                }
            }
            Connections {
                target: confirmButton
                function onClicked() {
                    if (confirmButton.mode === 2)
                        omniProcessObject.record()
                }
            }
        }

        Image {
            id: playButton
            anchors.left: recordButton.right
            anchors.top: parent.top
            anchors.leftMargin: 8
            anchors.bottomMargin: 2
            source: "../img/thumSrc.png"
            width: 30
            height: 30
            Icon {
                id: playIcon
                icon: IconType.play
                anchors.fill: parent
                size: 15
                color: "cyan"
            }

            RoundMouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    if (pressed) {
                        confirmButton.mode = 3
                        confirmButton.text = "play  "
                        blurNotif.visible = true
                        notifContainer.visible = true
                    }
                }
            }
            Connections {
                target: confirmButton
                function onClicked() {
                    if (confirmButton.mode === 3)
                        omniProcessObject.play()
                }
            }
        }
    }

    Image {
        id: reloadButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 30
        source: "../img/thumSrc.png"
        width: 40
        height: 40
        Icon {
            icon: IconType.refresh
            anchors.fill: parent
            size: 20
            color: "cyan"
        }

        RoundMouseArea {
            anchors.fill: parent
            onPressedChanged: {
                if (pressed) {
                    confirmButton.mode = 0
                    confirmButton.text = "reload"
                    blurNotif.visible = true
                    notifContainer.visible = true
                }
            }
        }

        Connections {
            target: confirmButton
            function onClicked() {
                if (confirmButton.mode === 0) {
                    omniProcessObject.requestConfig()
                    omniProcessObject.setBrightness(
                                brightnessSlider.value.toFixed(2))
                    omniProcessObject.setSaturation(
                                saturationSlider.value.toFixed(2))
                }
            }
        }
    }

    Image {
        id: uploadButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -30
        source: "../img/thumSrc.png"
        width: 40
        height: 40
        Icon {
            icon: IconType.save
            anchors.fill: parent
            size: 20
            color: "cyan"
        }

        RoundMouseArea {
            anchors.fill: parent
            onPressedChanged: {
                if (pressed) {
                    confirmButton.mode = 1
                    confirmButton.text = "upload"
                    blurNotif.visible = true
                    notifContainer.visible = true
                }
            }
        }
        Connections {
            target: confirmButton
            function onClicked() {
                if (confirmButton.mode === 1)
                    omniProcessObject.saveConfig()
            }
        }
    }

    Flickable {
        width: 250
        height: parent.height
        contentHeight: greenRangeH.height * 5 * 3 + 50 * 5 + 200
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.right: parent.right

        SliderCustom {
            id: brightnessSlider
            height: 50
            from: -64
            to: 64
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "brightness"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            onValueChanged: omniProcessObject.setBrightness(value.toFixed(2))
        }

        SliderCustom {
            id: saturationSlider
            height: 50
            from: 0
            to: 100
            anchors.top: brightnessSlider.bottom
            anchors.topMargin: 10

            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "saturation"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            onValueChanged: omniProcessObject.setSaturation(value.toFixed(2))
        }

        RangeSliderCustom {
            id: greenRangeH
            height: 50
            anchors.top: saturationSlider.bottom
            anchors.topMargin: 10

            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "greenRangeH"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }

            first.onMoved: omniProcessObject.setGreenHmin(first.value)
            second.onMoved: omniProcessObject.setGreenHmax(second.value)
        }
        RangeSliderCustom {
            id: greenRangeS
            height: 50
            anchors.top: greenRangeH.bottom
            anchors.topMargin: 10

            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "greenRangeS"
                fontSize: 5
                color: "cyan"
            }

            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setGreenSmin(first.value)
            second.onMoved: omniProcessObject.setGreenSmax(second.value)
        }
        RangeSliderCustom {
            id: greenRangeV
            height: 50
            anchors.top: greenRangeS.bottom
            anchors.topMargin: 10

            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "greenRangeV"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setGreenVmin(first.value)
            second.onMoved: omniProcessObject.setGreenVmax(second.value)
        }
        RangeSliderCustom {
            id: orangeRangeH
            height: 50

            anchors.top: greenRangeV.bottom
            anchors.topMargin: 40
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "orangeRangeH"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setOrangeHmin(first.value)
            second.onMoved: omniProcessObject.setOrangeHmax(second.value)
        }
        RangeSliderCustom {
            id: orangeRangeS
            height: 50

            anchors.top: orangeRangeH.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "orangeRangeS"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setOrangeSmin(first.value)
            second.onMoved: omniProcessObject.setOrangeSmax(second.value)
        }
        RangeSliderCustom {
            id: orangeRangeV
            height: 50

            anchors.top: orangeRangeS.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "orangeRangeV"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setOrangeVmin(first.value)
            second.onMoved: omniProcessObject.setOrangeVmax(second.value)
        }
        RangeSliderCustom {
            id: whiteRangeH
            height: 50

            anchors.top: orangeRangeV.bottom
            anchors.topMargin: 40
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "whiteRangeH"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }

            first.onMoved: omniProcessObject.setWhiteHmin(first.value)
            second.onMoved: omniProcessObject.setWhiteHmax(second.value)
        }
        RangeSliderCustom {
            id: whiteRangeS
            height: 50

            anchors.top: whiteRangeH.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "whiteRangeS"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setWhiteSmin(first.value)
            second.onMoved: omniProcessObject.setWhiteSmax(second.value)
        }
        RangeSliderCustom {
            id: whiteRangeV
            height: 50

            anchors.top: whiteRangeS.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "whiteRangeV"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setWhiteVmin(first.value)
            second.onMoved: omniProcessObject.setWhiteVmax(second.value)
        }

        RangeSliderCustom {
            id: yellowRangeH
            height: 50

            anchors.top: whiteRangeV.bottom
            anchors.topMargin: 40
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "yellowRangeH"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }

            first.onMoved: omniProcessObject.setYellowHmin(first.value)
            second.onMoved: omniProcessObject.setYellowHmax(second.value)
        }
        RangeSliderCustom {
            id: yellowRangeS
            height: 50

            anchors.top: yellowRangeH.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "yellowRangeS"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setYellowSmin(first.value)
            second.onMoved: omniProcessObject.setYellowSmax(second.value)
        }
        RangeSliderCustom {
            id: yellowRangeV
            height: 50

            anchors.top: yellowRangeS.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "yellowRangeV"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setYellowVmin(first.value)
            second.onMoved: omniProcessObject.setYellowVmax(second.value)
        }
        RangeSliderCustom {
            id: blackRangeH
            height: 50

            anchors.top: yellowRangeV.bottom
            anchors.topMargin: 40
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "blackRangeH"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setBlackHmin(first.value)
            second.onMoved: omniProcessObject.setBlackHmax(second.value)
        }
        RangeSliderCustom {
            id: blackRangeS
            height: 50

            anchors.top: blackRangeH.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "blackRangeS"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setBlackSmin(first.value)
            second.onMoved: omniProcessObject.setBlackSmax(second.value)
        }
        RangeSliderCustom {
            id: blackRangeV
            height: 50

            anchors.top: blackRangeS.bottom
            anchors.topMargin: 10
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: "blackRangeV"
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: parent.first.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            AppText {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: parent.second.value.toFixed(2)
                fontSize: 5
                color: "cyan"
            }
            first.onMoved: omniProcessObject.setBlackVmin(first.value)
            second.onMoved: omniProcessObject.setBlackVmax(second.value)
        }
    }

    Rectangle {
        id: blurNotif
        anchors.fill: parent
        opacity: 0.6
        visible: false
        color: "#24243b"
        MouseArea {
            anchors.fill: parent
        }
    }
    Rectangle {
        id: notifContainer
        width: blurNotif.width
        height: 100
        anchors.verticalCenter: parent.verticalCenter
        color: "#d745cf"
        visible: false

        AppButton {
            id: cancelButton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -width
            anchors.verticalCenter: parent.verticalCenter
            minimumHeight: 0
            minimumWidth: 0
            horizontalPadding: 2
            verticalPadding: 2
            width: 100
            height: 20
            backgroundColor: "transparent"
            borderWidth: 2
            borderColor: "cyan"
            radius: 5
            text: "cancel"
            onClicked: {

                blurNotif.visible = false
                notifContainer.visible = false
            }
        }

        AppButton {
            id: confirmButton
            property int mode: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: width
            anchors.verticalCenter: parent.verticalCenter
            minimumHeight: 0
            minimumWidth: 0
            horizontalPadding: 2
            verticalPadding: 2
            width: 100
            height: 20
            backgroundColor: "transparent"
            borderWidth: 2
            borderColor: "cyan"
            radius: 5
            text: "confirm"
            onClicked: {

                blurNotif.visible = false
                notifContainer.visible = false
            }
        }
    }
}
