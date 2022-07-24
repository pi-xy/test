import QtQuick

import "../js/Common.js" as Common
import "../js/Main.js" as Main
import "../js/Block.js" as Block

Item {
    id: block
    width: game.cellSize * 3
    height: game.cellSize * 3
    x: (game.cellSize * game.db.horizontalCellCount) / 2.0 - (game.cellSize * 2)
    y: 0

    property int matrixOriginX: 0
    property int matrixOriginY: 0
    property bool rested: false

    function tileInfos() {
        return Block.tileInfos(block)
    }

    function angle() {
        return Block.angle(rot)
    }

    function setAngle(ang) {
        return rot.angle = ang
    }

    function matrixXPos() {
        return Block.matrixXPos(block)
    }

    function matrixYPos() {
        return Block.matrixYPos(block)
    }

    function matrixXIndex() {
        return Block.matrixXIndex(block, Common.cellSize(canvas))
    }

    function matrixYIndex() {
        return Block.matrixYIndex(block, Common.cellSize(canvas))
    }

    function moveLeft() {
        Block.moveLeft(game, block)
    }

    function moveRight() {
        Block.moveRight(game, block)
    }

    function rotate() {
        Block.rotate(game, block)
    }

    function fallByOne() {
        Block.fallByOne(game, block)
    }

    function flashCompletedTiles() {
        return Block.flashCompletedTiles(game)
    }

    function isResting() {
        return Block.isResting(game, block)
    }

    function willRest() {
        return Block.willRest(game, block)
    }
}
