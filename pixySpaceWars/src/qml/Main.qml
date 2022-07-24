import QtQuick
import QtQuick.Shapes
import QtMultimedia

Rectangle {
    id: main
    objectName: "Main"
    color: "#000000"

    property int lives: 3

    property alias start: start
    property alias score: score
    property alias ships: ships

    property alias stageOutro: stageOutro

    property var stage

    signal startGame
    signal startStage
    signal endStage

    onStartGame: stageIntro.startAnimation()
    onEndStage: main.createAndStartStage()

    Connections {
        target: stageIntro
        function onDidFinish() {
            startStage()
        }
    }

    Connections {
        target: stageOutro
        function onDidFinish() {
            endStage()
        }
    }

    function startGameOver() {
        var currentHighScore = 0

            if (dataStore.getObject("highScoreTable", "highestScore", "score") != null) {
                currentHighScore =  parseInt(dataStore.getObject("highScoreTable", "highestScore", "score")); 
            }

            if (main.score.score > currentHighScore) {
                dataStore.setObject("highScoreTable", "highestScore", "score", main.score.score)
                window.saveGameData()     
                currentHighScore = main.score.score
            }
        
            stage.stop()
            score.visible = false

            gameover.setHighScore(currentHighScore)
            gameover.visible = true
            gameover.startAnimation()
    }

    onLivesChanged: {
        if (main.lives == 3) {
            ships.life1.visible = true
            ships.life2.visible = true
            ships.life3.visible = true
        } else if (main.lives == 2) {
            ships.life1.visible = true
            ships.life2.visible = true
            ships.life3.visible = false
        } else if (main.lives == 1) {
            ships.life1.visible = true
            ships.life2.visible = false
            ships.life3.visible = false
        } else {
            startGameOver()
        }
    }

    onStartStage: {
        score.resetScore()
        createAndStartStage()
    }

    function createAndStartStage() {
        if (main.stage) {
            main.stage.destroy()
        }
        var c = Qt.createComponent("Stage1.qml")  
        main.stage = c.createObject(main, {})

        main.stage.start()
    }

    function displayHighScore() {
        if (dataStore.getObject("highScoreTable", "highestScore", "score") != null) {          
            var highScore = parseInt(dataStore.getObject("highScoreTable", "highestScore", "score"))  
            score.updateHiScore(highScore)
            score.visible = true
        } else {
            score.visible = false
        }
    }

    Component.onCompleted: {
        player.play()
        //displayHighScore()        
    } 

    MediaPlayer {
        id: player
        source: "../audio/background-music.mp3"
        audioOutput: AudioOutput {}
        loops: MediaPlayer.Infinite
    }

    MainBackground { id: mainBackground }
    Lives { id: ships }
    Score { id: score }
    Start { id: start }
    StageIntro { id: stageIntro }
    StageOutro { id: stageOutro }
    GameOver { id: gameover }
}