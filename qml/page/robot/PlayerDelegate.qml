// PlayerDelegate.qml
import QtQuick 2.15

Rectangle {
    width: 20
    height: 20
    radius: 10
    color: "blue"

    property int x_: 0
    property int y_: 0

    // Random positioning within the field
    x: x_ - width / 2
    y: y_ - height / 2
}
