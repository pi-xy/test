import QtQuick

Rectangle {
    id: container
    width: window.width
    height: window.height
    color: "#222222"

    property alias canvas: canvas

    Rectangle {
        id: canvas
        width: Math.min(window.width, window.height)
        height: Math.min(window.width, window.height)
        color: "#87ceeb"

        SpriteSequence {
                property bool mirror: false
                id: spriteSequence
                x: parent.width / 2.0
                y: parent.height / 2.0
                width: parent.width * 0.10
                height: parent.width * (0.10 * 192/128)
                interpolate: false
                antialiasing: false
                smooth: false
                running: true

                Sprite {
                    name: "standing"
                    source: "foxy-spritesheet.svg"
                    frameCount: 1
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 250
                    to: { "standing": 90, "wagging": 5, "waggingAndBlinking" : 5}
                }

                Sprite {
                    name: "wagging"
                    source: "foxy-spritesheet.svg"
                    frameX: 1 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 100
                    to: { "standing": 1}
                }

                Sprite {
                    name: "waggingAndBlinking"
                    source: "foxy-spritesheet.svg"
                    frameX: 4 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 33
                    to: { "waggingAndBlinkingReversed": 1 }
                }

                Sprite {
                    name: "waggingAndBlinkingReversed"
                    source: "foxy-spritesheet.svg"
                    frameX: 4 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 33
                    reverse: true
                    to: { "standing": 1 }
                }

                Sprite {
                    name: "walking"
                    source: "foxy-spritesheet.svg"
                    frameX: 8 * 128
                    frameCount: 8
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 1000 / 30
                    to: { "walking": 1}
                }


                Sprite {
                    name: "standingReverse"
                    source: "foxy-spritesheet.svg"
                    frameX: 24 * 128
                    frameCount: 1
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 250
                    to: { "standingReverse": 90, "waggingReverse": 5, "waggingAndBlinkingReverse" : 5}
                }

                Sprite {
                    name: "waggingReverse"
                    source: "foxy-spritesheet.svg"
                    frameX: 25 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 100
                    to: { "standingReverse": 1}
                }

                Sprite {
                    name: "waggingAndBlinkingReverse"
                    source: "foxy-spritesheet.svg"
                    frameX: 28 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 33
                    to: { "waggingAndBlinkingReverseReversed": 1 }
                }

                Sprite {
                    name: "waggingAndBlinkingReverseReversed"
                    source: "foxy-spritesheet.svg"
                    frameX: 28 * 128
                    frameCount: 3
                    frameWidth: 128
                    frameHeight: 192
                    frameDuration: 33
                    reverse: true
                    to: { "standingReverse": 1 }
                }

                Sprite {
                    name: "walkingReverse"
                    source: "foxy-spritesheet.svg"
                    frameX: 16 * 128
                    frameCount: 8
                    frameWidth: 128
                    frameHeight: 192
                    //reverse: true
                    frameDuration: 1000 / 30
                    to: { "walkingReverse": 1}
                }
            }




    }
}

