import QtQuick 2.0
import QtQuick.Controls 2.5
import Felgo 3.0
import "../control"

Rectangle {
    color: "transparent"
    width: 240
    height: 240
    onVisibleChanged: {
        imageZedTimer.stop()
        if (visible) {
            imageZedTimer.start()
            zedProcessObject.requestConfig()
        }
    }

    Timer {
        id: imageZedTimer
        running: false
        repeat: true
        interval: 30
        property bool tmp: false
        onTriggered: {
            zedViewer.reload()
        }
    }

    Image {
        id: zedViewer
        width: zedProcessObject.image.width
        height: zedProcessObject.image.height
        cache: false
        asynchronous: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        property bool counter: false

        function reload() {
            counter = !counter
            source = "image://zed/image?id=" + counter
        }

        Image {
            id: recordButton
            anchors.left: parent.left
            anchors.bottom: parent.top
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
                        zedProcessObject.record()
                }
            }
        }

        Image {
            id: playButton
            anchors.left: recordButton.right
            anchors.bottom: parent.top
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
                        zedProcessObject.play()
                }
            }
        }

        Image {
            id: useMagentaButton
            anchors.left: playButton.right
            anchors.bottom: parent.top
            anchors.leftMargin: 8
            anchors.bottomMargin: 2
            source: "../img/thumSrc.png"
            width: 30
            height: 30
            Text {
                id: useMagentaTxt
                text: "C"
                anchors.fill: parent
                scale: 0.5
                color: "cyan"
            }

            RoundMouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    if (pressed) {
                        if (useMagentaTxt.text === "C") {
                            useMagentaTxt.text = "M"
                            zedProcessObject.setUseMagenta(true)
                        } else {
                            useMagentaTxt.text = "C"
                            zedProcessObject.setUseMagenta(false)
                        }
                    }
                }
            }
        }
    }

    function reloadValue() {}

    Connections {
        target: zedProcessObject
        function onConfigUpdated() {
            ballRangeH.first.value = zedProcessObject.ballHmin
            ballRangeH.second.value = zedProcessObject.ballHmax
            ballRangeS.first.value = zedProcessObject.ballSmin
            ballRangeS.second.value = zedProcessObject.ballSmax
            ballRangeV.first.value = zedProcessObject.ballVmin
            ballRangeV.second.value = zedProcessObject.ballVmax
            useMagentaTxt.text = zedProcessObject.useMagenta ? "M" : "C"
        }
    }

    RangeSliderCustom {
        id: ballRangeH
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.right: parent.right
        anchors.rightMargin: 40
        AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            text: "ballRangeH"
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

        first.onMoved: zedProcessObject.setBallHmin(first.value)
        second.onMoved: zedProcessObject.setBallHmax(second.value)
    }
    RangeSliderCustom {
        id: ballRangeS
        height: 50
        anchors.top: ballRangeH.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: ballRangeH.horizontalCenter

        AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            text: "ballRangeS"
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
        first.onMoved: zedProcessObject.setBallSmin(first.value)
        second.onMoved: zedProcessObject.setBallSmax(second.value)
    }
    RangeSliderCustom {
        id: ballRangeV
        height: 50
        anchors.top: ballRangeS.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: ballRangeH.horizontalCenter

        AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            text: "ballRangeV"
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
        first.onMoved: zedProcessObject.setBallVmin(first.value)
        second.onMoved: zedProcessObject.setBallVmax(second.value)
    }

    Image {
        id: reloadButton
        anchors.horizontalCenter: ballRangeH.horizontalCenter
        anchors.horizontalCenterOffset: width
        anchors.top: ballRangeV.bottom
        anchors.topMargin: 20
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
                if (confirmButton.mode === 0)
                    zedProcessObject.requestConfig()
            }
        }
    }

    Image {
        id: uploadButton
        anchors.horizontalCenter: ballRangeH.horizontalCenter
        anchors.horizontalCenterOffset: -width
        anchors.top: ballRangeV.bottom
        anchors.topMargin: 20
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
                    zedProcessObject.saveConfig()
            }
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
