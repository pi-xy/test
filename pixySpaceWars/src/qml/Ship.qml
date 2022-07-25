import QtQuick
import QtQuick.Shapes
import QtQuick.Particles

import "../js/Engine.js" as Engine

Rectangle {
    id: ship
    color: "transparent"

    width: Math.ceil(parent.width * 0.10)
    height: Math.ceil(parent.height * 0.10)

    property var fireButtonDownFrame: 0

    property bool dead : false

    Connections {
        id: connections
        target: window

        property int xMoveSize: 0
        
        function onFrameSwapped() {
            if (connections.xMoveSize > 0) {
                ship.x = Math.min(ship.x + connections.xMoveSize, canvas.width - ship.width)
            } else if (connections.xMoveSize < 0) {
                ship.x = Math.max(ship.x + connections.xMoveSize, 0)
            }
        }
    
        function onRightButtonPressed() {
            if (!ship.parent.started()) { return }
            if (connections.xMoveSize < 0) {connections.xMoveSize = 0 }
            connections.xMoveSize += 2
        }

        function onRightButtonReleased() {
            if (!ship.parent.started()) { return }
            if (connections.xMoveSize > 0) { connections.xMoveSize = 0 }
        }

        function onLeftButtonPressed() {
            if (!ship.parent.started()) { return }
            if (connections.xMoveSize > 0) { connections.xMoveSize = 0 }
            connections.xMoveSize -= 2
        }

        function onLeftButtonReleased() {
            if (!ship.parent.started()) { return }
            if (connections.xMoveSize < 0) { connections.xMoveSize = 0 }
        }

        function onBlueButtonPressed() {
            if (!ship.parent.started()) { return }
            fireButtonDownFrame = pixyEngine.frameNumber()
        }

        function onBlueButtonReleased() {
            if (!ship.parent.started()) { return }
            var secondsHeld = (pixyEngine.frameNumber() -
            fireButtonDownFrame) / pixyEngine.fps()

            //createLaser(secondsHeld * 15)
            createLaser(4)
        }
    }

    Laser { visible: false }
    function createLaser(width) {
        var c = Qt.createComponent("Laser.qml")  
        var b = c.createObject(ship.parent, {
            "x": Math.ceil((ship.x + (ship.width / 2)) - (width / 2)) - 2,
            "y": Math.ceil(ship.y - (width * 10)),
            "width": width,
            "height": width * 10
        })
    }

    ShipIcon {}

    function hit() {
        if (dead) { return }
        dead = true
        hitAnimation.running = true 
    }

    function afterHit() {
        dead = false
        opacity = 1
        scale = 1
        rotation = 0
    }

    SequentialAnimation {
        id: hitAnimation
        loops: 1

        ParallelAnimation {
            //loops: 1
        
            PropertyAnimation {
                target: ship
                property: "scale"
                from: 1
                to: 0.10
                duration: 250
                easing.type: Easing.OutInBounce
            }

            PropertyAnimation {
                target: ship
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }

            RotationAnimation {
                target: ship
                from: 0
                to: 360
                duration: 250
                loops: 1
            }
        }
        ScriptAction {
            script: afterHit()
        }
    }
}
