import QtQuick 2.0
import Felgo 3.0

Item {
    id: parentItem
    width: 300
    height: 300

    readonly property real _scale: width / 300
    property int option: 0

    Component.onCompleted: {
        runTxt.color = "cyan"
    }

    onOptionChanged: {
        runTxt.color = "black"
        killTxt.color = "black"
        allOnTxt.color = "black"
        allOffTxt.color = "black"
        if (option === 0)
            runTxt.color = "cyan"
        else if (option === 1)
            killTxt.color = "cyan"
        else if (option === 2)
            allOnTxt.color = "cyan"
        else if (option === 3)
            allOffTxt.color = "cyan"

        state = ""
    }

    Image {
        id: onButton
        source: "../img/thumSrc.png"
        width: 50 * _scale
        height: 50 * _scale
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        Behavior on x {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        Behavior on y {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }

        AppText {
            id: runTxt
            anchors.fill: parent
            anchors.margins: 4
            text: "run"
            fontSizeMode: "Fit"
        }
        RoundMouseArea {
            id: onMouse
            anchors.fill: parent
            onClicked: parentItem.option = 0
        }
    }

    Image {
        id: offButton
        source: "../img/thumSrc.png"
        width: 50 * _scale
        height: 50 * _scale
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        Behavior on x {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        Behavior on y {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        AppText {
            id: killTxt
            anchors.fill: parent
            anchors.margins: 4
            text: "kill"
            fontSizeMode: "Fit"
        }
        RoundMouseArea {
            id: offMouse
            anchors.fill: parent
            onClicked: parentItem.option = 1
        }
    }
    Image {
        id: onAllButton
        source: "../img/thumSrc.png"
        width: 50 * _scale
        height: 50 * _scale
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        Behavior on x {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        Behavior on y {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        AppText {
            id: allOnTxt
            anchors.fill: parent
            anchors.margins: 4
            text: "rAll"
            fontSizeMode: "Fit"
        }
        RoundMouseArea {
            id: allOnMouse
            anchors.fill: parent
            onClicked: parentItem.option = 2
        }
    }
    Image {
        id: offAllButton
        source: "../img/thumSrc.png"
        width: 50 * _scale
        height: 50 * _scale
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        Behavior on x {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        Behavior on y {
            PropertyAnimation {
                easing.type: Easing.InOutCirc
            }
        }
        AppText {
            id: allOffTxt
            anchors.fill: parent
            anchors.margins: 4
            text: "kAll"
            fontSizeMode: "Fit"
        }
        RoundMouseArea {
            id: allOffMouse
            anchors.fill: parent
            onClicked: parentItem.option = 3
        }
    }

    states: [
        State {
            name: "opened"
            PropertyChanges {
                target: onButton
                x: (150 * _scale * Math.cos(
                        -Math.PI / 2)) - width / 2 + parentItem.width / 2
                y: (150 * _scale * Math.sin(
                        -Math.PI / 2)) - width / 2 + parentItem.width / 2
            }

            PropertyChanges {
                target: offButton
                x: (150 * _scale * Math.cos(
                        -Math.PI / 2 + 0.707)) - width / 2 + parentItem.width / 2
                y: (150 * _scale * Math.sin(
                        -Math.PI / 2 + 0.707)) - width / 2 + parentItem.width / 2
            }
            PropertyChanges {
                target: onAllButton
                x: (150 * _scale * Math.cos(
                        -Math.PI / 2 - 0.707)) - width / 2 + parentItem.width / 2
                y: (150 * _scale * Math.sin(
                        -Math.PI / 2 - 0.707)) - width / 2 + parentItem.width / 2
            }
            PropertyChanges {
                target: offAllButton
                x: (150 * _scale * Math.cos(
                        -Math.PI / 2 - 0.707 * 2)) - width / 2 + parentItem.width / 2
                y: (150 * _scale * Math.sin(
                        -Math.PI / 2 - 0.707 * 2)) - width / 2 + parentItem.width / 2
            }
        }
    ]
}
