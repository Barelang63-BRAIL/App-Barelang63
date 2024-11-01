import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.5
import "../control"
import "arduino"

Rectangle {
    color: "transparent"

    SwipeView {
        id: view
        anchors.fill: parent
        orientation: Qt.Vertical

        Timer {
            id: kiperFrameTimer
            interval: 30
            repeat: true
            triggeredOnStart: false
            onTriggered: {
                kiperframeid.updateFrame()
            }
        }

        DribblerComp {}

        GrabberComp {}

        KickComp {
            id: kickComp
        }
        KiperFrameComp {
            id: kiperframeid
        }

        onCurrentIndexChanged: {
            kiperFrameTimer.stop()
            if (currentIndex === 3) {
                kiperFrameTimer.start()
            }
        }
    }
}
