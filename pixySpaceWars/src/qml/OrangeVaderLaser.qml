import QtQuick

Rectangle {
    id: laser
    color: "#FE7700"
    radius: width

    Connections {
        id: connections
        target: window

        function onFrameSwapped() {

            if (!laser.visible) {
                return
            }
            
            if (stage.vaderLaserAtPoint(Qt.point(laser.x, laser.y))) {
                laser.destroy()
            } else {
                if (laser.y < canvas.height) {
                    laser.y += Math.ceil(canvas.height * 0.0005)
                } else {
                    laser.destroy()
                }
            }
        }
    }
}


