import QtQuick 2.0
import QtQuick.Controls 2.0

Slider {
    id: aSlider
    orientation: Qt.Vertical
    value: 0.5
    from: 0
    to: 6.28

    background: Rectangle {
        //        x: aSlider.leftPadding + aSlider.availableWidth / 2 - width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        y: aSlider.topPadding
        implicitWidth: 4
        implicitHeight: 200
        width: implicitWidth
        height: aSlider.availableHeight
        radius: 2
        color: "cyan"
        Rectangle {
            x: parent.width / 2 - width / 2
            height: aSlider.visualPosition * parent.height
            width: parent.width
            color: "gray"
            radius: 2
        }
    }
    handle: Image {
        source: "../img/thumSrc.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y: aSlider.topPadding + aSlider.visualPosition * (aSlider.availableHeight - height)
        width: 25
        height: 25
    }
}
