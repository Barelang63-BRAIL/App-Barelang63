import QtQuick 2.0
import QtQuick.Controls 2.0

Slider {
    id: aSlider
    value: 0.5
    from: 0
    to: 6.28

    background: Rectangle {
        x: aSlider.leftPadding
        y: aSlider.topPadding + aSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: aSlider.availableWidth
        height: implicitHeight
        radius: 2
        color: "gray"
        Rectangle {
            width: aSlider.visualPosition * parent.width
            height: parent.height
            color: "cyan"
            radius: 2
        }
    }
    handle: Image {
        source: "../img/thumSrc.png"
        x: aSlider.leftPadding + aSlider.visualPosition * (aSlider.availableWidth - width)
        y: aSlider.topPadding + aSlider.availableHeight / 2 - height / 2
        width: 25
        height: 25
    }
}
