import QtQuick 2.0
import QtQuick.Controls 2.0

//Rectangle {
//    id: checkRect
//    width: 50
//    height: 50
//    color: "transparent"
CheckBox {
    id: control
    checked: true

    //        anchors.fill: parent
    indicator: Rectangle {
        id: outer
        implicitWidth: parent.width
        implicitHeight: implicitWidth

        //        anchors.fill: checkRect
        radius: implicitWidth / 2
        border.color: "cyan"
        color: "transparent"

        Rectangle {
            width: parent.width / 1.2
            height: width
            anchors.horizontalCenter: outer.horizontalCenter
            anchors.verticalCenter: outer.verticalCenter
            radius: width / 2
            color: control.down ? "transparent" : "cyan"
            visible: control.checked
        }
    }
} //}
