import QtQuick

Block {
    id: block
    width: game.cellSize * 4
    height: game.cellSize * 4
    property alias rot: rot
    transform: Rotation {
        id: rot
        origin.x: game.cellSize * 2
        origin.y: game.cellSize * 2
        angle: 0
    }
    property var tiles: {
        var component = Qt.createComponent("Tile.qml")
        var tile1 = component.createObject(block, {
                                               "x": 0,
                                               "y": game.cellSize,
                                               "color": "#05A89D"
                                           })
        var tile2 = component.createObject(block, {
                                               "x": game.cellSize,
                                               "y": game.cellSize,
                                               "color": "#05A89D"
                                           })
        var tile3 = component.createObject(block, {
                                               "x": game.cellSize * 2,
                                               "y": game.cellSize,
                                               "color": "#05A89D"
                                           })
        var tile4 = component.createObject(block, {
                                               "x": game.cellSize * 3,
                                               "y": game.cellSize,
                                               "color": "#05A89D"
                                           })
        return [tile1, tile2, tile3, tile4]
    }

    property var invalidMovesLeft: {
        return [[0, 0], [90, -2], [180, 0], [270, -1]]
    }

    property var invalidMovesRight: {
        return [[0, game.db.horizontalCellCount
                 - 4], [90, game.db.horizontalCellCount
                        - 3], [180, game.db.horizontalCellCount
                               - 4], [270, game.db.horizontalCellCount - 2]]
    }

    property var invalidRotationsForXAxis: {
        return [[90, -1], [90, -2], [270, -1], [270, game.db.horizontalCellCount
                                                - 2], [90, game.db.horizontalCellCount
                                                       - 3], [270, game.db.horizontalCellCount - 3]]
    }

    property var invalidRotationsForYAxis: {
        return [[0, game.db.verticalCellCount
                 - 2], [0, game.db.verticalCellCount
                        - 3], [0, game.db.verticalCellCount
                               - 1], [180, game.db.verticalCellCount - 3]]
    }
}
