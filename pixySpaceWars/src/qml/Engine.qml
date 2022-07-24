import QtQuick

Rectangle {
    id: engine

    property double t: 0.0 // time
    property double m: 1.0 // mass

    property double xPos: 0.0 // x position
    property double vX: 0.0 // x velocity
    property double fX: 0.0 // x force
    //property double aXInc: 150.0 // x acceleration

    property double yPos: 0.0 // y position
    property double vY: 0.0 // y velocity
    property double fY: 0.0 // y force
    //property double aYInc: 150.0 // y acceleration

    property var xPosStopMax: null
    property var xPosStopMin: null
    property var yPosStopMax: null
    property var yPosStopMin: null

    property var xVStart: null
    property var yVStart: null


    signal xPosChange
    signal yPosChange

    Connections {
        target: window

        function onFrameSwapped() {
            positionXY(1/pixyEngine.fps())
        }
    }

    function positionXY(dt) {
        var aX = fX / m // x acceleration
        var aY = fY / m  // y acceleration

        //aXInc *= 0.10
        //aYInc *= 0.10

        if (fX != 0 && xVStart != null) {
            vX = fX > 0 ? xVStart : -xVStart
        }

        vX = vX + aX * dt
        var xPosNew = xPos + vX * dt

        if (xPosNew != xPos) {
            if ((xPosStopMax == null || xPosNew <= xPosStopMax) &&
                (xPosStopMin == null || xPosNew >= xPosStopMin)) {
                xPos = xPosNew
            } else {
                xPos = xPosNew > xPos ? xPosStopMax : xPosStopMin
            }
            xPosChange()
        }

        
        vY = vY + aY * dt
        var yPosNew = yPos + vY * dt

        if (yPosNew != yPos) {
            if ((yPosStopMax == null || yPosNew <= yPosStopMax) &&
            (yPosStopMin == null || yPosNew >= yPosStopMin)) {
                yPos = yPosNew
            } else {
                yPos = yPosNew > yPos ? yPosStopMax : yPosStopMin
            }
            yPosChange()
        }

        t += dt        
    }
}