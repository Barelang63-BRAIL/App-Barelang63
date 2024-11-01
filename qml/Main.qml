import Felgo 3.0
import QtQuick 2.15
import "page"
import "control"

GameWindow {

    id: gameWindow
    backButtonAutoAcceptGlobally: true

    function checkProgram() {
        var run = false
        var i = 0
        for (i = 0; i < listView.model.count; i++) {
            if (listView.itemAtIndex(i).state !== "on") {
                if (!startButton.onoff)
                    run = true
                break
            }
        }
        scaleBig.running = run

        listView.itemAtIndex(0).state = programProcessObject.zed ? "on" : ""
        listView.itemAtIndex(1).state = programProcessObject.amcl ? "on" : ""
        listView.itemAtIndex(2).state = programProcessObject.arduino ? "on" : ""
        listView.itemAtIndex(3).state = programProcessObject.omni ? "on" : ""
        listView.itemAtIndex(
                    4).state = programProcessObject.basestation ? "on" : ""
        listView.itemAtIndex(
                    5).state = programProcessObject.strategy ? "on" : ""
        listView.itemAtIndex(6).state = programProcessObject.stm ? "on" : ""
        hbImg.state = programProcessObject.heartBeat ? "on" : ""
        razorImg.state = programProcessObject.razor ? "on" : ""
    }

    Timer {
        interval: 200
        onTriggered: checkProgram()
        running: true
        repeat: true
        triggeredOnStart: true
    }

    Scene {
        id: scene
        Rectangle {
            color: "#24243b"
            anchors.fill: scene.fullWindowAnchorItem
        }
        ScaleAnimator {
            id: scaleBig
            target: rectAnim
            from: 0
            to: 1
            duration: 1000
            running: false
            easing.type: Easing.InOutCirc
            onFinished: {
                scaleSmall.running = true
            }
        }
        ScaleAnimator {
            id: scaleSmall
            target: rectAnim
            from: 1
            to: 0
            duration: 1000
            running: false
            easing.type: Easing.InOutCirc
        }

        Rectangle {
            id: rectAnim
            width: bg.width
            height: bg.height * 2
            color: "red"
            scale: 0
            //            radius: width / 2
            anchors.verticalCenter: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle {
            id: rectStartAnim
            width: bg.width
            height: bg.height * 2
            color: "cyan"
            scale: 0
            //            radius: width / 2
            anchors.verticalCenter: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ScaleAnimator {
            id: scaleBigStart
            target: rectStartAnim
            from: 0
            to: 1
            duration: 3000
            running: false

            //            easing.type: Easing.OutCirc
        }
        ScaleAnimator {
            id: scaleSmallStart
            target: rectStartAnim
            from: rectStartAnim.scale
            to: 0
            duration: 1000
            running: false
            easing.type: Easing.InCirc
        }
        Image {
            id: bg
            source: "img/bg.png"
            anchors.fill: parent
        }

        ZedPage {
            id: zedPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem
        }
        AmclPage {
            id: amclPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem
        }
        ArduinoPage {
            id: arduinoPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem
        }

        OmniPage {
            id: omniPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem
            Rectangle {
                width: 50
                height: 20
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                Image {
                    id: hbImg
                    anchors.fill: parent
                    source: "img/heartbeatOff.png"
                    states: [
                        State {
                            name: "on"
                            PropertyChanges {
                                target: hbImg
                                source: "img/heartbeatOn.png"
                            }
                        }
                    ]
                }
            }
        }

        BasestationPage {
            id: basestationPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem
        }

        StmPage {
            id: stmPage
            visible: false
            anchors.fill: scene.gameWindowAnchorItem

            Rectangle {
                width: 50
                height: 20
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                Image {
                    id: razorImg
                    anchors.fill: parent
                    source: "img/heartbeatOff.png"
                    states: [
                        State {
                            name: "on"
                            PropertyChanges {
                                target: razorImg
                                source: "img/heartbeatOn.png"
                            }
                        }
                    ]
                }
            }
        }

        //        Rectangle {
        //            id: robotPage
        //            anchors.fill: scene.gameWindowAnchorItem
        //            anchors.margins: 75
        //            color: "#d745cf"
        //            visible: false
        //            radius: 5
        RobotPage {
            id: robotPage
            width: 500
            height: 200
            anchors.fill: scene.gameWindowAnchorItem
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 15
            visible: false
        }

        //        Rectangle {
        //            width: parent.width
        //            height: parent.height
        //            anchors.fill: scene.gameWindowAnchorItem
        //            RotationPage {
        //                anchors.fill: parent
        //            }
        //        }

        //        }
        Rectangle {
            id: rect
            color: "transparent"
            width: parent.width
            height: parent.height
            anchors.fill: scene.gameWindowAnchorItem
            Image {
                width: 400
                height: 20
                source: "img/topBarLine.png"
                anchors.top: rect.top
                anchors.topMargin: -10
                anchors.horizontalCenter: rect.horizontalCenter
            }

            ListView {
                id: listView
                anchors.horizontalCenter: rect.horizontalCenter
                anchors.top: rect.top
                anchors.topMargin: 10
                width: (listView.model.count + 1) * (25 + 10)
                height: 35
                orientation: Qt.Horizontal
                spacing: 20

                model: ListModel {
                    ListElement {
                        text: "ZED"
                        iconOn: "../img/zedOn.png"
                        iconOff: "../img/zedOff.png"
                    }
                    ListElement {
                        text: "AMCL"
                        iconOn: "../img/amclOn.png"
                        iconOff: "../img/amclOff.png"
                    }
                    ListElement {
                        text: "Arduino"
                        iconOn: "../img/arduinoOn.png"
                        iconOff: "../img/arduinoOff.png"
                    }
                    ListElement {
                        text: "Omni"
                        iconOn: "../img/omniOn.png"
                        iconOff: "../img/omniOff.png"
                    }
                    ListElement {
                        text: "BASESTATION"
                        iconOn: "../img/basestationOn.png"
                        iconOff: "../img/basestationOff.png"
                    }
                    ListElement {
                        text: "ROBOTINFO"
                        iconOn: "../img/aiOn.png"
                        iconOff: "../img/aiOff.png"
                    }
                    ListElement {
                        text: "STM"
                        iconOn: "../img/stmOn.png"
                        iconOff: "../img/stmOff.png"
                    }
                }

                delegate: TopBarButton {
                    //                    textSize: 5
                    width: 25
                    height: width
                    iconOff: model.iconOff
                    iconOn: model.iconOn
                    //                    verticalMargin: 0
                    //                    horizontalMargin: 0
                    //                    horizontalPadding: 0
                    //                    verticalPadding:0
                    //                    minimumHeight: 0
                    //                    minimumWidth: 0
                    //                    borderWidth: 0
                    radius: width / 2

                    onOnoffChanged: {
                        startButton.index = index
                        stmPage.visible = false
                        robotPage.visible = false
                        basestationPage.visible = false
                        omniPage.visible = false
                        arduinoPage.visible = false
                        amclPage.visible = false
                        zedPage.visible = false

                        stmProcessObject.setOpened(false)

                        if (index === 6) {
                            stmPage.visible = true
                            stmProcessObject.setOpened(true)
                        } else if (index === 5)
                            robotPage.visible = true
                        else if (index === 4)
                            basestationPage.visible = true
                        else if (index === 3)
                            omniPage.visible = true
                        else if (index === 2)
                            arduinoPage.visible = true
                        else if (index === 1)
                            amclPage.visible = true
                        else if (index === 0)
                            zedPage.visible = true
                    }
                }
            }
            StartOptionComp {
                id: startOptionComp
                width: 175
                height: 175
                anchors.verticalCenter: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                onOptionChanged: {
                    var txt = ["run", "kill", "rAll", "kAll"]
                    startTxtId.text = txt[option]
                }
            }

            StartButton {
                id: startButton
                property int index: -1
                width: 100
                height: width
                anchors.bottom: rect.bottom
                anchors.bottomMargin: -50
                anchors.horizontalCenter: rect.horizontalCenter
                AppText {
                    id: startTxtId
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -10
                    fontSize: 10
                    fontSizeMode: "Fit"
                    text: "run"
                    color: "cyan"
                }

                onOnoffChanged: {
                    scale = onoff ? 1.1 : 1
                    if (onoff) {
                        scaleBigStart.start()
                        startTimer.restart()
                    } else {
                        scaleBigStart.stop()
                        startTimer.stop()
                        scaleSmallStart.start()
                    }
                }
                onIndexChanged: {
                    screenProcessObject.setPageActive(startButton.index)
                }
                Timer {
                    id: startTimer
                    interval: scaleBigStart.duration
                    repeat: false
                    running: false
                    triggeredOnStart: false
                    onTriggered: {
                        screenProcessObject.runProcess(startButton.index,
                                                       startTxtId.text)
                    }
                }
            }
            Image {
                id: optComp
                source: "img/thumSrc.png"
                width: 30
                height: 30
                anchors.left: startButton.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.bottom
                RoundMouseArea {
                    anchors.fill: parent
                    //                    property bool _tmp: false
                    onPressedChanged: {
                        if (pressed) {
                            optComp.scale = 1.2
                            //                            _tmp = !_tmp
                            //                            startOptionComp.state = _tmp ? "opened" : ""
                            startOptionComp.state = "opened"
                        } else
                            optComp.scale = 1
                    }
                }
            }
        }
    }
}
