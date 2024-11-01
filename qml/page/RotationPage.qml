import QtQuick 2.0
import Felgo 3.0
import QtSensors 5.15

Item {
    Gyroscope {
        id: rotSensor
        active: true
        property real yaw: 0
        property real last_time: 0
        onReadingChanged: {
            var now = reading.timestamp
            var dt = now - last_time
            last_time = now
            dt /= 1e6
            yaw += reading.z * dt
        }
    }
    AppButton {
        text: "reset"
        onClicked: {
            rotSensor.yaw = 0
        }
    }

    AppText {
        id: sensorTxt
        fontSize: 5
        color: "black"
        anchors.fill: parent
        text: rotSensor.yaw
    }
}
