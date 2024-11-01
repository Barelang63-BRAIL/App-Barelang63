import QtQuick 2.0

import Felgo 3.0

Rectangle {
    id: startButton
    property bool onoff: false
    property string iconOn: ""
    property string iconOff: ""
    width: 25
    height: width
    radius: width / 2
    color: "transparent"

    Image {
        id: iconImg
        source: "../img/startButton.png"
        anchors.fill: parent
    }
    RoundMouseArea {
        id: roundMouseArea
        anchors.fill: parent
        onPressedChanged: onoff = !onoff
    }
    onOnoffChanged: onoff ? startButton.state = "on" : startButton.state = ""
}
