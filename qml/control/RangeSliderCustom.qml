import QtQuick 2.0
import QtQuick.Controls 2.0

RangeSlider {
    id: aSlider
    first.value: 25
    second.value: 225
    from: 0
    to: 255

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
            x: aSlider.first.visualPosition * parent.width
            width: aSlider.second.visualPosition * parent.width - x
            height: parent.height
            color: "cyan"
            radius: 2
        }
    }
    first.handle: Image {
        source: "../img/thumSrc.png"
        x: aSlider.leftPadding + aSlider.first.visualPosition * (aSlider.availableWidth - width)
        y: aSlider.topPadding + aSlider.availableHeight / 2 - height / 2
        width: 25
        height: 25
    }
    second.handle: Image {
        source: "../img/thumSrc.png"
        x: aSlider.leftPadding + aSlider.second.visualPosition * (aSlider.availableWidth - width)
        y: aSlider.topPadding + aSlider.availableHeight / 2 - height / 2
        width: 25
        height: 25
    }
}
