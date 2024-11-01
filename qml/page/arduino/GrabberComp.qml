import QtQuick 2.0
import Felgo 3.0
import QtCharts 2.3
import "../../control"

Rectangle {
    width: 200
    height: 200
    color: "transparent"
    function drawLine() {
        lineLeft.append(10, 100)
        lineLeft.append(20, 200)
        lineLeft.append(30, 300)

        lineRight.append(10, 300)
        lineRight.append(20, 100)
        lineRight.append(30, 500)
        //        lineSeries.remove(lineSeries.at(0))
    }
    Component.onCompleted: drawLine()

    ChartView {
        id: chartView
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignRight
        legend.labelColor: "white"
        backgroundColor: "transparent"

        ValueAxis {
            id: xAxis
            min: 0
            max: 100
            labelFormat: "%.0f"
            labelsVisible: false
        }

        ValueAxis {
            id: yAxis
            min: 0
            max: 1024
            labelFormat: "%.0f"
            labelsColor: "cyan"
        }

        LineSeries {
            id: lineLeft
            name: "left"
            axisX: xAxis
            axisY: yAxis
            color: "cyan"
        }
        LineSeries {
            id: lineRight
            name: "right"
            axisX: xAxis
            axisY: yAxis
            color: "#d745cf"
        }
    }
}
