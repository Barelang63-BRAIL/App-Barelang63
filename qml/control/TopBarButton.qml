import QtQuick 2.0
import Felgo 3.0

Rectangle {
    id: topBarRect
    property bool onoff: false
    property string iconOn: ""
    property string iconOff: ""
    width: 25
    height: width
    radius: width / 2
    color: "transparent"

    Image {
        id: iconImg
        source: iconOff
        anchors.fill: parent
    }
    AppText {
        id: txt
        anchors.fill: topBarRect
        fontSize: 4
        fontSizeMode: "HorizontalFit"
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        color: "grey"
    }
    RoundMouseArea {
        id: roundMouseArea
        anchors.fill: parent
        onClicked: onoff = !onoff
    }

    //    onOnoffChanged: onoff ? topBarRect.state = "on" : topBarRect.state = ""
    states: [
        State {
            name: "on"
            PropertyChanges {
                target: iconImg
                source: iconOn
            }
            PropertyChanges {
                target: txt
                color: "#ff6aad"
            }
        }
    ]
}
