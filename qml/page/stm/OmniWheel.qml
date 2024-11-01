import QtQuick 2.0
import Felgo 3.0

Item {
    id: omniWheel
    width: 150
    height: 150
    property real centerX: width / 2
    property real centerY: height / 2
    property real radius: 55

    property int w1: 0
    property int w2: 0
    property int w3: 0

    //    Component.onCompleted: {
    //        repeater.itemAt(1).state = "cw"
    //    }
    onW1Changed: repeater.itemAt(1).state = w1 > 0 ? "cw" : w1 < 0 ? "ccw" : ""
    onW2Changed: repeater.itemAt(0).state = w2 > 0 ? "cw" : w2 < 0 ? "ccw" : ""
    onW3Changed: repeater.itemAt(2).state = w3 > 0 ? "cw" : w3 < 0 ? "ccw" : ""

    // ItemAt(0) corresponds to "back"
    // ItemAt(1) corresponds to "left"
    // ItemAt(2) corresponds to "right"
    Repeater {
        id: repeater
        model: 3

        Wheel {
            id: wheel
            // Calculate position
            rotation: index * (360 / repeater.model)
            x: centerX - (wheel.width / 2) + (omniWheel.radius * Math.cos(
                                                  (94 * Math.PI / 180) + index
                                                  * ((360 / repeater.model) * Math.PI / 180)))
            y: centerY - (wheel.height / 2) + (omniWheel.radius * Math.sin(
                                                   (94 * Math.PI / 180) + index
                                                   * ((360 / repeater.model) * Math.PI / 180)))
        }
    }

    Image {

        id: name
        source: "../../img/omniWheel.png"
        anchors.fill: parent
        anchors.margins: 20 * omniWheel.scale
    }
}
