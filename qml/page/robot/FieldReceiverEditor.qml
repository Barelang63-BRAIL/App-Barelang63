// FootballField.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: footballField
    property real scaleField: 0.2
    width: 1200 * scaleField
    height: 800 * scaleField
    property real robotX: 600
    property real robotY: 400
    property real robotTheta: 90
    property real ballX: 250
    property real ballY: 250

    color: "transparent"
    clip: true

    Rectangle {
        id: field
        anchors.fill: parent
        color: "transparent"
        // Soccer field
        Rectangle {
            width: 1200 * scaleField
            height: 800 * scaleField
            color: "transparent"
            border.color: "white"
            border.width: 1
            radius: 10 * scaleField
            anchors.centerIn: parent

            // Center circle
            Rectangle {
                width: 260 * scaleField
                height: width
                color: "transparent"
                border.color: "white"
                border.width: 1
                radius: width / 2
                anchors.centerIn: parent
            }
            Rectangle {
                anchors.centerIn: parent
                color: "white"
                width: 1
                height: 800 * scaleField
            }

            // Goal areas
            Rectangle {
                width: 50 * scaleField
                height: 300 * scaleField
                color: "transparent"
                border.color: "white"
                border.width: 1
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 50 * scaleField
                height: 300 * scaleField
                color: "transparent"
                border.color: "white"
                border.width: 1
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

            // Penalty areas
            Rectangle {
                width: 180 * scaleField
                height: 500 * scaleField
                color: "transparent"
                border.color: "white"
                border.width: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }

            Rectangle {
                width: 180 * scaleField
                height: 500 * scaleField
                color: "transparent"
                border.color: "white"
                border.width: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
            }
        }
    }

    property var players: ListModel
}
