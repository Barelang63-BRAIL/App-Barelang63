import QtQuick 2.0
import Felgo 3.0

Rectangle {
    width: 5
    height: 50
    property real min: 0
    property real max: 1024
    property real value: 0

    onValueChanged: {
        idHurung.height = value / max * height
    }

    color: "transparent"
    Rectangle {
        id: sisa
        color: "grey"
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        radius: 5
    }
    Rectangle {
        id: idHurung
        width: parent.width
        color: "cyan"
        anchors.bottom: parent.bottom
        radius: 5
    }
}
