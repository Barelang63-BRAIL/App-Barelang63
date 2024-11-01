import QtQuick 2.0
import Felgo 3.0

Rectangle {
    color: "transparent"
    Rectangle {
        //        color: "transparent"
        //        width: 500
        //        height: 500
        AppText {
            id: txtBase
            anchors.top: parent.top
            anchors.topMargin: 90
            anchors.left: parent.left
            anchors.leftMargin: 50
            text: "Gamestate: " + "\nRunning: " + "\nRole" + "\nRoleAuto: "
            color: "cyan"
            fontSize: 5
            lineHeight: 2
        }
        Rectangle {
            width: 3
            height: txtBase.lineCount * 50 // (txtBase.lineHeight * 2 + 10)
            color: "cyan"
            anchors.right: txtBase.left
            anchors.rightMargin: 30
            anchors.verticalCenter: txtBase.verticalCenter
        }
    }
}
