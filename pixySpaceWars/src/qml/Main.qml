import QtQuick
import QtMultimedia

import "../js/Common.js" as Common
import "../js/Main.js" as Main

Rectangle {
    id: game
    width: parent.width
    height: parent.height
    color: "#222222"

    property int cellSize: Common.cellSize(canvas)
    property int dropSpeed: 80
    property var component
    property var block
    property var blocks: []
    property int level: 1
    property int lineCount: 0
    property int score: 0

    property alias hudScore: hudScore
    property alias hudLines: hudLines
    property alias hudLevel: hudLevel

    property alias hudHighScore: hudHighScore
    property alias hudGameOver: hudGameOver
    property alias startImage: startImage
    property alias gameOver: gameOver

    property alias playfield: playfield

    property alias ticker: ticker

    property alias player: player

    property alias db: db

    GameData {
        id: db
    }

    MediaPlayer {
        id: player
        source: "qrc:/pixyBloky/resources/theme.mp3"
        audioOutput: AudioOutput {}
        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: {
        Main.gameOnCompleted()
    }

    Rectangle {
        id: playfield
        width: game.cellSize * game.db.horizontalCellCount
        height: parent.height
        color: "#000000"
        x: (game.width - (game.cellSize * game.db.horizontalCellCount)) / 2
        y: (game.width - (game.cellSize * game.db.verticalCellCount))
        visible: false

        Rectangle {
            color: "#80ffffff"
            width: 1
            height: parent.height
            x: -1
            y: 0
            z: 1024
        }

        Rectangle {
            color: "#80ffffff"
            width: 1
            height: parent.height
            x: parent.width
            y: 0
            z: 1024
        }
    }

    Text {
        id: hudLines
        z: 256
        visible: true
        text: ""
        color: "#ffffff"
        font.pointSize: playfield.width * 0.055 < 1 ? 1 : playfield.width * 0.055
        x: playfield.x
        y: game.cellSize * 0.2
        width: playfield.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        rightPadding: playfield.width * 0.033
    }

    Text {
        id: hudScore
        z: 256
        visible: true
        text: ""
        color: "#ffffff"
        font.pointSize: playfield.width * 0.055 < 1 ? 1 : playfield.width * 0.055
        x: playfield.x
        y: game.cellSize * 0.2
        width: playfield.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        leftPadding: playfield.width * 0.033
    }

    Text {
        id: hudLevel
        z: 256
        visible: false
        text: ""
        color: "#ffffff"
        font.pointSize: playfield.width * 0.055 < 1 ? 1 : playfield.width * 0.055
        x: 0
        y: game.cellSize * 0.2
        width: parent.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: hudGameOver
        z: 256
        visible: false
        text: "GAME OVER"
        color: "#ffffff"
        font.bold: true
        font.pointSize: playfield.width * 0.1 < 1 ? 1 : playfield.width * 0.1
        x: playfield.x
        y: playfield.height * 0.33
        width: playfield.width
        anchors.horizontalCenter: playfield.Center
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: hudHighScore
        z: 256
        visible: false
        text: "hello"
        color: "#ffffff"
        font.bold: true
        font.pointSize: playfield.width * 0.066 < 1 ? 1 : playfield.width * 0.066
        x: playfield.x
        anchors.top: hudGameOver.bottom
        width: playfield.width
        horizontalAlignment: Text.AlignHCenter
        topPadding: playfield.height * 0.05
    }

    Connections {
        target: window

        function onMusicEnabledStateChanged(enabled) {
            Main.onMusicEnabledStateChanged(game, enabled)
        }

        function onContinueGameButtonPressed() {
            Main.onContinueGameButtonPressed(game)
        }

        function onRestartGameButtonPressed() {
            Main.onRestartGameButtonPressed(game, window)
        }

        function onRoundButtonPressed() {
            Main.onRoundButtonPressed(game, window)
        }

        function onRedButtonPressed() {
            Main.onRedButtonPressed(game)
        }

        function onGreenButtonPressed() {
            Main.onGreenButtonPressed(game)
        }

        function onYellowButtonPressed() {
            Main.onYellowButtonPressed(game)
        }

        function onBlueButtonPressed() {
            Main.onBlueButtonPressed(game)
        }

        function onUpButtonPressed() {
            Main.onUpButtonPressed(game)
        }

        function onDownButtonPressed() {
            Main.onDownButtonPressed(game)
        }

        function onDownButtonReleased() {
            Main.onDownButtonReleased(game)
        }

        function onLeftButtonPressed() {
            Main.onLeftButtonPressed(game)
        }

        function onRightButtonPressed() {
            Main.onRightButtonPressed(game)
        }

        function onMenuShown() {
            Main.onMenuShown(game)
        }
    }

    Image {
        id: startImage
        width: parent.width
        height: parent.height
        source: "../resources/start.svg"
    }

    Image {
        id: gameOver
        visible: false
        width: parent.width
        height: parent.height
        source: "../resources/game-over.svg"
    }

    Timer {
        id: ticker
        running: false
        repeat: true
        interval: 1000 / 60
        property int tick: 0
        property int freq: dropSpeed

        onTriggered: {
            Main.tickerOnTriggered(game, window, dataStore)
        }
    }

    function increaseScore(points) {
        Main.increaseScore(game, points)
    }

    function increaseLevel() {
        Main.increaseLevel(game)
    }

    function increaseLineCount(lines) {
        Main.increaseLineCount(game, lines)
    }
}
