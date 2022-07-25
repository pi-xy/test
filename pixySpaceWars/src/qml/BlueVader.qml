import QtQuick

Rectangle {
    id: vader
    width: Math.ceil(parent.width * 0.08)
    height: Math.ceil(parent.width * 0.08)
    color: "transparent"
    antialiasing: true

    property alias animatedSprite: animatedSprite
    property alias timer: timer

    property bool dead : false

    BlueVaderLaser { visible: false }
    function createLaser() {
        var width = Math.ceil(parent.width * 0.007)
        var c = Qt.createComponent("BlueVaderLaser.qml")  
        var b = c.createObject(vader.parent, {
            "x": Math.ceil((vader.x + (vader.width / 2)) - (width / 2)) - 2,
            "y": Math.ceil(vader.y + vader.height),
            "width": width,
            "height": width * 5,
            "z": -1
        })
    }

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            var rnd = Math.floor(Math.random() * 20)
            if (!dead && vader.parent.started() && rnd == 1) {
                //createLaser(Math.ceil(parent.width * 0.07))
            }
        }
    }

    AnimatedSprite {
        id: animatedSprite
        source: "blue.svg"
        frameWidth: 64
        frameHeight: 64
        frameCount: 2
        frameDuration: 1000
        width: Math.ceil(parent.width * 1.0)
        height: width
        interpolate: false
        opacity: 0.90
    
    }

    function hit() {
        dead = true
        hitAnimation.running = true 
    }

    ParallelAnimation {
        id: hitAnimation
        loops: 1
        
        PropertyAnimation {
            target: vader
            property: "scale"
            from: 1
            to: 10
            duration: 250
            easing.type: Easing.OutInBounce
        }

        PropertyAnimation {
            target: vader
            property: "opacity"
            from: 1
            to: 0
            duration: 250
        }

        RotationAnimation {
            target: vader
            from: 0
            to: 90 + Math.floor(Math.random() * 270)
            duration: 125
            loops: 2
        }
    }
}