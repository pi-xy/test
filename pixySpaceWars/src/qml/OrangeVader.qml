import QtQuick

Rectangle {
    id: vader
    width: Math.ceil(parent.width * 0.08)
    height: Math.ceil(parent.width * 0.08)
    color: "transparent"
    antialiasing: true

    property bool dead : false
    
    property alias animatedSprite: animatedSprite
    property alias timer: timer

    OrangeVaderLaser { visible: false }
    function createLaser(width) {
        var c = Qt.createComponent("OrangeVaderLaser.qml")  
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
            var rnd = Math.floor(Math.random() * 60)
            if (!dead && vader.parent.started() && rnd == 1) {
                createLaser(Math.ceil(parent.width * 0.07))
            }
        }
    }

    Behavior on x {
        NumberAnimation { duration: 50 }
    }

    AnimatedSprite {
        id: animatedSprite
        source: "orange.svg"
        frameWidth: 57
        frameHeight: 57
        frameCount: 2
        frameDuration: 1000
        width: Math.ceil(parent.width * 0.9)
        height: width
        interpolate: false
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