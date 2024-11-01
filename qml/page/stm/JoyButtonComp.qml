import QtQuick 2.0
import Felgo 3.0

Item {
    id: joyButtonItem
    width: 500
    height: 500
    Item {
        width: 500 * parent.width / 500
        height: 500 * parent.height / 500
        anchors.centerIn: parent

        Image {
            id: name
            source: "../../img/joyButton.png"
            anchors.fill: parent
        }
        Rectangle {
            id: indicator
            width: 30 * parent.width / 400
            height: 30 * parent.width / 400
            x: parent.width / 2 - width / 2
            y: parent.width / 2 - width / 2
            radius: width / 2
            color: "cyan"
        }

        MouseArea {
            id: mouseButton
            anchors.fill: parent
            property real ori: 0
            onPressed: {
                ori = Math.atan2(mouseButton.mouseY - height / 2,
                                 mouseButton.mouseX - width / 2)
                var dist = Math.sqrt(Math.pow(mouseX - height / 2,
                                              2) + Math.pow(
                                         mouseY - height / 2, 2))
                ori = ori * 180 / Math.PI
                if (dist <= width / 2) {
                    if (ori > -45 && ori < 45)
                        joyButtonItem.state = "right"
                    else if (ori > 45 && ori < 125)
                        joyButtonItem.state = "backward"
                    else if (ori > 135 || ori < -135)
                        joyButtonItem.state = "left"
                    else if (ori > -135 && ori < -45)
                        joyButtonItem.state = "forward"
                }
            }
            onReleased: joyButtonItem.state = ""
        }
    }
    states: [
        State {
            name: "right"
            PropertyChanges {
                target: indicator
                x: indicator.x + parent.width / 2
            }
        },
        State {
            name: "left"
            PropertyChanges {
                target: indicator
                x: indicator.x - parent.width / 2
            }
        },
        State {
            name: "forward"
            PropertyChanges {
                target: indicator
                y: indicator.y - parent.width / 2
            }
        },
        State {
            name: "backward"
            PropertyChanges {
                target: indicator
                y: indicator.y + parent.width / 2
            }
        }
    ]
}
