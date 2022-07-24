import QtQuick

import "../js/Common.js" as Common

Rectangle {
    id: gameData

    property int verticalCellCount: Common.verticalCellCount()
    property int horizontalCellCount: Common.horizontalCellCount()
    property var tileMap: []

    function tilesAboveIndex(indexY) {
        let tiles = []
        for (var v = indexY - 1; v != 0; v--) {
            for (var h = 0; h < gameData.horizontalCellCount; h++) {
                let tile = tileMap[v][h]
                if (tile !== null) {
                    tiles.push(tile)
                }
            }
        }
        return tiles
    }
    function removeTilesInACompletedLineAndMoveDown() {

        let foundACompleteLine = true

        while (foundACompleteLine) {
            foundACompleteLine = false

            for (var indexY = gameData.verticalCellCount - 1; indexY >= 0; indexY--) {
                let lineComplete = true
                let tilesInLine = []
                for (var indexX = 0; indexX < gameData.horizontalCellCount; indexX++) {
                    let tileInMap = tileMap[indexY][indexX]

                    if (tileInMap === null) {
                        lineComplete = false
                        break
                    }

                    tilesInLine.push(tileInMap)
                }
                if (lineComplete) {
                    foundACompleteLine = true
                    for (var indexXX = 0; indexXX < gameData.horizontalCellCount; indexXX++) {
                        let tileInMap = tileMap[indexY][indexXX]
                        removeTileFromTileMap(tileInMap)
                        tileInMap.visible = false
                    }

                    tilesAboveIndex(indexY).forEach(function (tile) {
                        if (tile.parent.angle() === 0)
                            tile.y += game.cellSize
                        else if (tile.parent.angle() === 90)
                            tile.x += game.cellSize
                        else if (tile.parent.angle() === 180)
                            tile.y -= game.cellSize
                        else
                            tile.x -= game.cellSize
                        updateTileMapWithInfos([tile.tileInfo()])
                    })
                }
            }
        }
    }

    function tilesInACompletedLine() {
        let completedTiles = []
        let completedLineCount = 0
        for (var indexY = 0; indexY < gameData.verticalCellCount; indexY++) {
            let lineComplete = true
            for (var indexX = 0; indexX < gameData.horizontalCellCount; indexX++) {
                let tileInMap = tileMap[indexY][indexX]
                if (tileInMap === null) {
                    lineComplete = false
                }
            }
            if (lineComplete) {
                completedLineCount++
                for (var indexXX = 0; indexXX < gameData.horizontalCellCount; indexXX++) {
                    let tileInMap = tileMap[indexY][indexXX]
                    completedTiles.push(tileInMap)
                }
            }
        }
        return [completedLineCount, completedTiles]
    }

    function tileNextTo(tile, indexYOffset, indexXOffset) {
        let tilePos = tilePosition(tile)

        let indexY = tilePos.indexY + indexYOffset
        let indexX = tilePos.indexX + indexXOffset

        if (indexY > tileMap.length - 1) {
            return true
        }
        if (indexX > tileMap[tilePos.indexY + indexYOffset].length - 1) {
            return true
        }

        let tileToRight = tileMap[indexY][indexX]
        if (tileToRight === null) {
            return false
        }

        let differentBlock = tile.parent !== tileToRight.parent

        //if (differentBlock) {
        //    tileToRight.color = "white"
        //}
        return differentBlock
    }

    function tileToRight(tile) {
        return tileNextTo(tile, 0, 1)
    }

    function tileToLeft(tile) {
        return tileNextTo(tile, 0, -1)
    }

    function tileAbove(tile) {
        return tileNextTo(tile, -1, 0)
    }

    function tileBelow(tile) {
        return tileNextTo(tile, 1, 0)
    }

    function tilePosition(tile) {
        for (var indexY = 0; indexY < gameData.verticalCellCount; indexY++) {
            for (var indexX = 0; indexX < gameData.horizontalCellCount; indexX++) {
                let tileInMap = tileMap[indexY][indexX]
                if (tileInMap === tile) {
                    return {
                        "indexY": indexY,
                        "indexX": indexX
                    }
                }
            }
        }
    }

    function tileAt(yIndex, xIndex) {
        return tileMap[yIndex][xIndex]
    }

    function tileExists(yIndex, xIndex) {
        return tileMap[yIndex][xIndex] !== null
    }

    function somethingBelow(block) {
        for (var i = 0; i < block.tileInfos().length; i++) {
            let tileInfo = block.tileInfos()[i]
            let xIndex = tileInfo.xIndex
            let yIndex = tileInfo.yIndex
            let tile = tileMap[yIndex][xIndex]

            if (yIndex + 1 === tileMap.length) {
                return true
            }

            if (tile !== null) {
                let tileBelow = tileMap[yIndex + 1][xIndex]
                if (tileBelow !== null && block !== tileBelow.parent) {
                    return true
                }
            }
        }
        return false
    }

    function overlaps(block) {
        for (var i = 0; i < block.tileInfos().length; i++) {
            let tileInfo = block.tileInfos()[i]
            let xIndex = tileInfo.xIndex
            let yIndex = tileInfo.yIndex
            let tile = tileMap[yIndex][xIndex]
            if (tile !== null && block !== tile.parent) {
                return true
            }
        }
        return false
    }

    function updateTileMapWithInfos(tileInfos) {
        for (var i = 0; i < tileInfos.length; i++) {
            updateTileMapWithInfo(tileInfos[i])
        }
    }

    function updateTileMapWithInfo(tileInfo) {
        let xIndex = tileInfo.xIndex
        let yIndex = tileInfo.yIndex
        let tile = tileInfo.tile
        removeTileFromTileMap(tile)
        // console.log("Updating:" + tile + " : with" + yIndex)
        tileMap[yIndex][xIndex] = tile
    }

    function removeTileFromTileMap(tile) {
        for (var v = 0; v < gameData.verticalCellCount; v++) {
            for (var h = 0; h < gameData.horizontalCellCount; h++) {
                let tileInMap = tileMap[v][h]
                if (tileInMap === tile) {
                    tileMap[v][h] = null

                    //tile.visible = false
                    //var index = tile.parent.tiles.indexOf(tile)
                    //if (index > -1) {
                    //    tile.parent.tiles.splice(index, 1)
                    // }
                    // tile.destroy()
                }
            }
        }
    }

    function initTileMap() {
        for (var v = 0; v < gameData.verticalCellCount; v++) {
            tileMap[v] = []
            for (var h = 0; h < gameData.horizontalCellCount; h++) {
                tileMap[v][h] = null
            }
        }
    }

    Component.onCompleted: {
        initTileMap()
    }
}
