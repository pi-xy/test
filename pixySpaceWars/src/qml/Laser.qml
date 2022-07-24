import QtQuick

Rectangle {
    id: laser
    //width: Math.max(2, canvas.width * 0.005)
    //height: canvas.height * 0.10
    //height: width * 10
    color: "#ffffff"

    Connections {
        id: connections
        target: window

        function onFrameSwapped() {

            if (!laser.visible) {
                return
            }
            
            if (stage.laserAtPoint(Qt.point(laser.x, laser.y))) {
                laser.destroy()
            } else {
                if (laser.y > -laser.height) {
                    laser.y -= Math.ceil(canvas.height * 0.05)
                } else {
                    laser.destroy()
                }
            }

            
        }
    }

    /* gradient: Gradient {
        GradientStop { position: 0.0; color: "red" }
        GradientStop { position: 0.33; color: "orange" }
        GradientStop { position: 1.0; color: "yellow" }
    }*/
}


