import QtQuick

import "../js/Main.js" as Main

Rectangle {
    id: tile

    width: game.cellSize
    height: game.cellSize

    color: "red"

    //border.color: "#ffffff" //"#222222"
    border.width: 1
    border.color: "#000000"
    radius: game.cellSize * 0.10
    antialiasing: true

    property alias text: text

    Text {
        id: text
        text: ""
        font.family: "Helvetica"
        font.pointSize: 8
        color: "white"
    }

    function tileInfo() {
        var globalCoordinares = tile.mapToItem(tile.parent.parent, 0, 0)
        var xIndex = globalCoordinares.x / game.cellSize
        var yIndex = globalCoordinares.y / game.cellSize
        return {
            "xIndex": xIndex,
            "yIndex": yIndex,
            "tile": tile
        }
    }

    function flash(firstTileFlashed) {
        animateOpacity.firstTileFlashed = firstTileFlashed
        animateOpacity.start()
    }

    SequentialAnimation {
        id: animateOpacity
        loops: 1

        property bool firstTileFlashed: false

        onRunningChanged: {
            if (!animateOpacity.running) {
                if (firstTileFlashed) {
                    Main.startTicker(game)
                }
            }
        }

        NumberAnimation {
            target: tile
            properties: "opacity"
            from: 1
            to: 0
            duration: 300
        }

        NumberAnimation {
            target: tile
            properties: "opacity"
            from: 0
            to: 1
            duration: 300
        }
    }
}
