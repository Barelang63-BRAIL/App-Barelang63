import QtQuick 2.0
import Felgo 3.0

Item {
    property real x_val: 0
    property real y_val: 0
    property real a_val: 0
    onX_valChanged: repeater.itemAt(0).text = repeater.itemAt(
                        0).axis + " : " + x_val.toFixed(2)

    onY_valChanged: repeater.itemAt(1).text = repeater.itemAt(
                        1).axis + " : " + y_val.toFixed(2)
    onA_valChanged: repeater.itemAt(2).text = repeater.itemAt(
                        2).axis + " : " + a_val.toFixed(2)

    Column {
        Repeater {
            id: repeater
            model: ListModel {
                ListElement {
                    axis: "x"
                }
                ListElement {
                    axis: "y"
                }
                ListElement {
                    axis: "a"
                }
            }
            AppText {
                text: model.axis
                property string axis: model.axis
                fontSize: 6
                color: "cyan"
            }
        }
    }
}
