import QtQuick

Block {
    id: block
    width: game.cellSize * 2
    height: game.cellSize * 2
    transform: Rotation {
        id: rot
        origin.x: game.cellSize
        origin.y: game.cellSize
        angle: 0
    }
    property var tiles: {
        var component = Qt.createComponent("Tile.qml")
        var tile1 = component.createObject(block, {
                                               "x": 0,
                                               "y": 0,
                                               "color": "#F7BA00"
                                           })
        var tile2 = component.createObject(block, {
                                               "x": game.cellSize,
                                               "y": 0,
                                               "color": "#F7BA00"
                                           })
        var tile3 = component.createObject(block, {
                                               "x": 0,
                                               "y": game.cellSize,
                                               "color": "#F7BA00"
                                           })
        var tile4 = component.createObject(block, {
                                               "x": game.cellSize,
                                               "y": game.cellSize,
                                               "color": "#F7BA00"
                                           })
        return [tile1, tile2, tile3, tile4]
    }

    property var invalidMovesLeft: {
        return [[0, 0]]
    }

    property var invalidMovesRight: {
        return [[0, game.db.horizontalCellCount - 2]]
    }

    property var invalidRotationsForXAxis: {
        return []
    }

    property var invalidRotationsForYAxis: {
        return []
    }

    //function canMoveLeft() {
    //    if (matrixXIndex() === 0)
    //        return false
    //    return true
    // }

    //function canMoveRight() {
    //    if (matrixXIndex() === game.db.horizontalCellCount - 2)
    //        return false
    //    return true
    // }

    //function canRotate() {
    //    return true
    //}
}
