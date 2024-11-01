import QtQuick 2.0
import Felgo 3.0
import QtQuick.Layouts 1.3

Item {
    id: wheelItem
    property alias leftArrow: leftArr
    property alias rightArrow: rightArr
    property alias rowLayout: row

    RowLayout {
        id: row
        spacing: 2
        Icon {
            id: leftArr
            icon: IconType.arrowleft
            size: 10
            color: "transparent"
        }

        Rectangle {
            id: rect
            color: "grey"
            width: 20 * wheelItem.scale
            height: 10 * wheelItem.scale
            radius: 4 * wheelItem.scale
        }

        Icon {
            id: rightArr
            icon: IconType.arrowright
            size: 10
            color: "transparent"
        }
        Component.onCompleted: {
            wheelItem.width = Layout.minimumWidth
        }
    }
    states: [
        State {
            name: "cw"
            PropertyChanges {
                target: rightArr
                color: "#d745cf"
            }
            PropertyChanges {
                target: leftArr
                color: "transparent"
            }
            PropertyChanges {
                target: rect
                color: "#d745cf"
            }
        },
        State {
            name: "ccw"
            PropertyChanges {
                target: rightArr
                color: "transparent"
            }
            PropertyChanges {
                target: leftArr
                color: "cyan"
            }
            PropertyChanges {
                target: rect
                color: "cyan"
            }
        }
    ]
}
