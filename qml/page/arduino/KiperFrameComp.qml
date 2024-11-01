import QtQuick 2.9
import Felgo 3.0
import QtGraphicalEffects 1.15

Rectangle {
    color: "transparent"
    width: 700
    height: 700

    property bool left_: false
    property bool right_: false
    property bool up_: false

    function updateFrame() {
        arduinoProcessObject.setFrame(left_, right_, up_)
    }

    Image {
        id: kiper
        width: 100
        height: 100
        source: "../../img/arduinoKiper.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }

    ColorOverlay {
        anchors.fill: kiper
        source: kiper
        color: "cyan"
    }

    Image {
        id: rightFrame
        source: "../../img/arduinoKiperFrame.png"
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.left: kiper.right
        anchors.verticalCenter: kiper.verticalCenter
    }
    ColorOverlay {
        id: rightOverlay
        anchors.fill: rightFrame
        source: rightFrame
        color: "#424242"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                right_ = !right_
                rightOverlay.color = right_ ? "cyan" : "#424242"
                updateFrame()
            }
        }
    }
    Image {
        id: leftFrame
        source: "../../img/arduinoKiperFrame.png"
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.right: kiper.left
        anchors.verticalCenter: kiper.verticalCenter
        rotation: 180
    }
    ColorOverlay {
        id: leftOverlay
        anchors.fill: leftFrame
        source: leftFrame
        color: "#424242"
        rotation: 180
        MouseArea {
            anchors.fill: parent
            onClicked: {
                left_ = !left_
                leftOverlay.color = left_ ? "cyan" : "#424242"
                updateFrame()
            }
        }
    }
    Image {
        id: upFrame
        source: "../../img/arduinoKiperFrame.png"
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.bottom: kiper.top
        anchors.horizontalCenter: kiper.horizontalCenter
        rotation: -90
    }
    ColorOverlay {
        id: upOverlay
        anchors.fill: upFrame
        source: upFrame
        color: "#424242"
        rotation: -90

        MouseArea {
            anchors.fill: parent
            onClicked: {
                up_ = !up_
                upOverlay.color = up_ ? "cyan" : "#424242"
                updateFrame()
            }
        }
    }
}
