import QtQuick

AnimatedSprite {
        id: shape
        source: "ship.svg"
        frameWidth: 58
        frameHeight: 58
        frameCount: 1
        frameDuration: 1000
        width: Math.ceil(parent.width * 0.9)
        height: width
        interpolate: false

        property alias engineAnimation: engineAnimation

        Rectangle {
            id: engine
            color: "red"
            width: parent.width * 0.20
            height: parent.width * 0.20
            anchors.centerIn: parent
            anchors.verticalCenterOffset : shape.height * 0.15
            visible: true
            //x: (parent.x + (parent.width / 2.0)) - (width / 2.0)
            //y: (parent.y + (parent.width / 2.0) - (width / 2.0)) * 1.20
            opacity: 0.85
            RotationAnimation {
                id: engineAnimation
                target: engine
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
                running: true
            }
        }
    }