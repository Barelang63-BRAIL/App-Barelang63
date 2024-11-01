import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.5

import "robot"

Rectangle {
    color: "transparent"
    SwipeView {
        id: view
        anchors.fill: parent
        orientation: Qt.Vertical

        FieldComp {
            id: fieldcomp
            scaleField: 0.25
            robotX: strategyProcessObject.robot_x
            robotY: strategyProcessObject.robot_y
            robotTheta: strategyProcessObject.robot_a
            ballX: strategyProcessObject.ball_x
            ballY: strategyProcessObject.ball_y
        }

        FieldReceiverEditor {
            id: footballField
            scaleField: 0.25
        }
    }
}
