import QtQuick 2.0
import Felgo 3.0

Rectangle {
    color: "transparent"
    width: 240
    height: 240
    onVisibleChanged: {
        imageTimer.stop()
        if (visible)
            imageTimer.start()
    }

    Timer {
        id: imageTimer
        running: false
        repeat: true
        interval: 30
        onTriggered: {
            amclViewer.reload()
        }
    }

    Image {
        id: amclViewer
        width: zedProcessObject.image.width
        height: zedProcessObject.image.height
        cache: false
        asynchronous: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        property bool counter: false
        function reload() {
            counter = !counter
            source = "image://amcl/image?id=" + counter
        }
    }
}
