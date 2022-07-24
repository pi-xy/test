import QtQuick

Rectangle {
    id: stage
    visible: true
    anchors.fill: parent
    color: "transparent"

    property alias timer: timer
    property alias ship: ship


    property int vaderInterval: 1000
    property bool moveRight: true

    property var vaders: []
    property var vadersA: []
    property var vadersB: []
    property var vadersC: []
    property var vadersD: []

    Component.onCompleted: {
        vadersA.push(v5A, v4A, v1A, v2A, v3A)
        vadersB.push(v5B, v4B, v1B, v2B, v3B)
        vadersC.push(v5C, v4C, v1C, v2C, v3C)
        vadersD.push(v5D, v4D, v1D, v2D, v3D)
        vaders = vadersA.concat(vadersB)
        vaders = vaders.concat(vadersC)
        vaders = vaders.concat(vadersD)

        if (parent.objectName !="Main") {
            start()
        }
    }

    function started() {
        return timer.running
    }

    function start() {
        stage.visible = true
        timer.running = true
        if (typeof main !== 'undefined') {
            main.score.visible = true
            main.ships.visible = true
        }
    }

    function stop() {
        stage.visible = false
        timer.running = false
        main.score.visible = false
        main.ships.visible = false
        main.displayHighScore()
    }

    function vaderLaserAtPoint(point) {
        if (point.x >= ship.x &&
            point.x <= ship.x + ship.width &&
            point.y >= ship.y &&
            point.y <= ship.y + ship.height) {
                if (!ship.dead) {
                    main.lives--
                }
                ship.hit()
                return true
        }
        return false
    }

    function laserAtPoint(point) {
        var hit = false
        vaders.forEach(function (vader) {
            if (!vader.dead && point.x >= vader.x &&
                point.x <= vader.x + vader.width &&
                point.y >= vader.y &&
                point.y <= vader.y + vader.height) {
                    if (!hit) {
                        vader.hit()
                        hit = true
                        main.score.updateScore(100)
                    }
            }
        });

        return hit
    }

    function vaderTouchesRightWall(vader) {
        if (vader.dead) { return false }
        return vader.x > canvas.width - (vader.width + vader.width / 2.0) 
    }

    function vaderTouchesLeftWall(vader) {
        if (vader.dead) { return false }
        return vader.x < vader.width / 2.0
    }

    function moveVadersDown() {
        v1A.y += v1A.height / 4.0
        v1B.y += v1A.height / 4.0
        v1C.y += v1A.height / 4.0
        v1D.y += v1A.height / 4.0
    }

    function checkWallTouch(vs) {
        var touched = false
        vs.every(function (vader) {
        if (vaderTouchesRightWall(vader)) {
            moveRight = false
            touched = true
            return false
        } else if (vaderTouchesLeftWall(vader)) {
            moveRight = true
            touched = true
            return false
        }    
        return true
        });

        return touched
    }

    function moveVadersA() {
        var dx = Math.ceil(v1A.width / 2.0) 
        if (moveRight) {
            v1A.x += dx
        } else {
            v1A.x -= dx
        }
    }

    function moveVadersB() {
        var dx = Math.ceil(v1B.width / 2.0) 
        if (moveRight) {
            v1B.x += dx
        } else {
            v1B.x -= dx
        }
    }

    function moveVadersC() {
        var dx = Math.ceil(v1C.width / 2.0) 
        if (moveRight) {
            v1C.x += dx
        } else {
            v1C.x -= dx
        }
    }

    function moveVadersD() {
        var dx = Math.ceil(v1C.width / 2.0) 
        if (moveRight) {
            v1D.x += dx
        } else {
            v1D.x -= dx
        }
    }

    function setVadersFrameRate() {
        vaders.every(function (vader) {
            vader.animatedSprite.frameDuration = stage.vaderInterval
            vader.timer.interval = stage.vaderInterval
           return true
        });
    }

    function determineVaderDirectionAndSpeed() {
        if (checkWallTouch(vaders)) {
            moveVadersDown()
            stage.vaderInterval = Math.max(250, stage.vaderInterval * 0.90)
            setVadersFrameRate()
        }
    }

    function thingsIntersect(a, b) {
        var aLeftOfB = a.x + a.width < b.x
        var aRightOfB = a.x > b.x + b.width
        var aAboveB = a.y > b.y + b.height
        var aBelowB = a.y + a.height < b.y
        return !( aLeftOfB || aRightOfB || aAboveB || aBelowB )
    }

    function determineIfVaderTouchingShip() {
        vaders.every(function (vader) {
            if (!vader.dead && thingsIntersect(vader, ship)) {
                main.lives = 0
                ship.hit()
            }
           return true
        })
    }

    function killVadersOffScreen() {
        vaders.every(function (vader) {
            if (!vader.dead && vader.y >= canvas.height) {
                 vader.hit()
            }
           return true
        })
    }

    function allVadersDead() {
        var allDead = true
        vaders.every(function (vader) {
            if (!vader.dead) {
                 allDead = false
            }
           return true
        })

        return allDead
    }

    Timer {
        id: timer
        interval: stage.vaderInterval
        running: false
        repeat: true

        onTriggered: {
            moveVadersA()
            moveVadersB()
            moveVadersC()
            moveVadersD()
            determineVaderDirectionAndSpeed()
            determineIfVaderTouchingShip()
            killVadersOffScreen()
            if (allVadersDead()) {
                timer.running = false
                if (parent.objectName == "Main") {
                    main.stage.ship.visible = false
                    main.stageOutro.startAnimation()
                }
            }
        }
    }

    BlueVader {
        id: v1A
        x: Math.ceil(canvas.width * 0.50 - (width / 2.0))
        y: Math.ceil(canvas.height * 0.50)
    }

    BlueVader {
        id: v2A
        x: v1A.x + Math.ceil((width * 1.33))
        y: v1A.y
    }

    BlueVader {
        id: v3A
        x: v2A.x + Math.ceil((width * 1.33))
        y: v1A.y
    }
    
    BlueVader {
        id: v4A
        x: v1A.x - Math.ceil((width * 1.33))
        y: v1A.y
    }

    BlueVader {
        id: v5A
        x: v4A.x - Math.ceil((width * 1.33))
        y: v1A.y
    }

    BlueVader {
        id: v1B
        x: Math.ceil(canvas.width * 0.50 - (width / 2.0))
        y: Math.ceil(canvas.height * 0.50 - width)
        Behavior on x {
            NumberAnimation { duration: 10 }
        }
    }

    BlueVader {
        id: v2B
        x: v1B.x + Math.ceil((width * 1.33))
        y: v1B.y
        Behavior on x {
            NumberAnimation { duration: 20 }
        }
    }

    BlueVader {
        id: v3B
        x: v2B.x + Math.ceil((width * 1.33))
        y: v1B.y
        Behavior on x {
            NumberAnimation { duration: 20 }
        }
    }
    
    BlueVader {
        id: v4B
        x: v1B.x - Math.ceil((width * 1.33))
        y: v1B.y
        Behavior on x {
            NumberAnimation { duration: 20 }
        }
    }

    BlueVader {
        id: v5B
        x: v4B.x - Math.ceil((width * 1.33))
        y: v1B.y
        Behavior on x {
            NumberAnimation { duration: 20 }
        }
    }

    YellowVader {
        id: v1C
        x: Math.ceil(canvas.width * 0.50 - (width / 2.0))
        y: Math.ceil(canvas.height * 0.50 - (width * 2))
    }

    YellowVader {
        id: v2C
        x: v1C.x + Math.ceil((width * 1.33))
        y: v1C.y
    }

    YellowVader {
        id: v3C
        x: v2C.x + Math.ceil((width * 1.33))
        y: v1C.y
    }
    
    YellowVader {
        id: v4C
        x: v1C.x - Math.ceil((width * 1.33))
        y: v1C.y
    }

    YellowVader {
        id: v5C
        x: v4C.x - Math.ceil((width * 1.33))
        y: v1C.y
    }

    OrangeVader {
        id: v1D
        x: Math.ceil(canvas.width * 0.50 - (width / 2.0))
        y: Math.ceil(canvas.height * 0.50 - (width * 3))
    }

    OrangeVader {
        id: v2D
        x: v1D.x + Math.ceil((width * 1.33))
        y: v1D.y
    }

    OrangeVader {
        id: v3D
        x: v2D.x + Math.ceil((width * 1.33))
        y: v1D.y
    }
    
    OrangeVader {
        id: v4D
        x: v1D.x - Math.ceil((width * 1.33))
        y: v1D.y
    }

    OrangeVader {
        id: v5D
        x: v4D.x - Math.ceil((width * 1.33))
        y: v1D.y
    }

    Ship {
        id: ship
        x: Math.ceil(stage.width / 2 - ship.width / 2)
        y: Math.ceil(stage.height - ship.height - (stage.height * 0.02))
    }    
}