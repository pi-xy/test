import QtQuick

Rectangle {
    id: gameOver
    visible: false
    anchors.fill: parent
    color: "transparent"

    FontLoader { id: fontloaderAnton; source: "../fonts/Anton-Regular.ttf" }

    property bool newHighScore: false

    Component.onCompleted: {
        if (parent.objectName != "Main") {
            visible = true
            newHighScore = true
            setHighScore(999)
            startAnimation()
        }
    } 

    function afterAnimation() {
        pixyEngine.reloadCanvas()
    }

    function startAnimation() {
       animationOut.running = true        
    }

    function setHighScore(highScore) {

        var text = ""
        if (newHighScore) {
            text += "NEW HIGH SCORE!!!"
        } else {
            text += "HIGH SCORE"
        }

        highScoreTitle.text = text
        highScoreTitleValue.text = highScore.toString().padStart(9, '0')
    }

    Text {
        id: gameOverTitle
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.centerIn: gameOver
        anchors.verticalCenterOffset : -canvas.height * 0.15
        text: "GAME OVER!"
        font.letterSpacing: (canvas.width * 0.170) * 0.04
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: canvas.width * 0.170
        opacity: 0.85      
    }

    Text {
        id: highScoreTitle
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.horizontalCenter : gameOver.horizontalCenter
        anchors.top : gameOverTitle.bottom
        text: "NEW HIGH SCORE!!!"
        font.letterSpacing: (canvas.width * 0.170) * 0.08
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: gameOverTitle.font.pixelSize * 0.50
        horizontalAlignment: Text.AlignHCenter
        lineHeight : 0.80
        opacity: 0.85      
    }

    Text {
        id: highScoreTitleValue
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.horizontalCenter : gameOver.horizontalCenter
        anchors.top : highScoreTitle.bottom
        text: ""
        font.letterSpacing: (canvas.width * 0.170) * 0.08
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: gameOverTitle.font.pixelSize * 0.50
        horizontalAlignment: Text.AlignHCenter
        opacity: 0.85      
    }

    SequentialAnimation {
            id: animationOut

            PauseAnimation { duration: 2500 }

            ParallelAnimation {
                PropertyAnimation {
                    id: titleFadeOutAnimation
                    target: gameOverTitle
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 500
                }

                PropertyAnimation {
                    id: titleScaleOutAnimation
                    target: gameOverTitle
                    property: "scale"
                    from: 1
                    to: 0
                    duration: 500
                    running: false
                    easing.type: Easing.InCirc
                }

                SequentialAnimation {
                    PauseAnimation { duration: 500 }
                    ParallelAnimation {
                        PropertyAnimation {
                            id: highScoreFadeOutAnimation
                            target: highScoreTitle
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 500
                        }

                        PropertyAnimation {
                            id: highScoreScaleOutAnimation
                            target: highScoreTitle
                            property: "scale"
                            from: 1
                            to: 0
                            duration: 500
                            running: false
                            easing.type: Easing.InCirc
                        }
                    }

                    PauseAnimation { duration: 100 }

                    ParallelAnimation {
                        PropertyAnimation {
                            id: highScoreValueFadeOutAnimation
                            target: highScoreTitleValue
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 500
                        }

                        PropertyAnimation {
                            id: highScoreValueScaleOutAnimation
                            target: highScoreTitleValue
                            property: "scale"
                            from: 1
                            to: 0
                            duration: 500
                            running: false
                            easing.type: Easing.InCirc
                        }
                    }

                    PauseAnimation { duration: 250 }

                    
                    ScriptAction {
                        script: afterAnimation()
                    }
                }
            }
        }  
}