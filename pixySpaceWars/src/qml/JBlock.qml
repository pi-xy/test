import QtQuick

Block {
    id: block
    transform: Rotation {
        id: rot
        origin.x: game.cellSize * 1.5
        origin.y: game.cellSize * 1.5
        angle: 0
    }
    property var tiles: {
        var component = Qt.createComponent("Tile.qml")
        var tile1 = component.createObject(block, {
                                               "x": 0,
                                               "y": 0,
                                               "color": "#0376BB"
                                           })
        var tile2 = component.createObject(block, {
                                               "x": 0,
                                               "y": game.cellSize,
                                               "color": "#0376BB"
                                           })
        var tile3 = component.createObject(block, {
                                               "x": game.cellSize,
                                               "y": game.cellSize,
                                               "color": "#0376BB"
                                           })
        var tile4 = component.createObject(block, {
                                               "x": game.cellSize * 2,
                                               "y": game.cellSize,
                                               "color": "#0376BB"
                                           })
        return [tile1, tile2, tile3, tile4]
    }

    property var invalidMovesLeft: {
        return [[0, 0], [90, -1], [180, 0], [270, 0]]
    }

    property var invalidMovesRight: {
        return [[0, game.db.horizontalCellCount
                 - 3], [90, game.db.horizontalCellCount
                        - 3], [180, game.db.horizontalCellCount
                               - 3], [270, game.db.horizontalCellCount - 2]]
    }

    property var invalidRotationsForXAxis: {
        return [[90, -1], [270, game.db.horizontalCellCount - 2]]
    }

    property var invalidRotationsForYAxis: {
        return [[0, game.db.verticalCellCount
                 - 2], [0, game.db.verticalCellCount - 1]]
    }
}
