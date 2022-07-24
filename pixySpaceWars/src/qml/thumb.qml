import QtQuick

import "../js/Common.js" as Common
import "../js/Main.js" as Main

Rectangle {
    id: game
    color: "#000000"
    anchors.fill: parent

    property alias db: db
    GameData {
        id: db
    }

    property int cellCount: 10
    property int cellSize: game.width / 20

    property var block
    property var blocks: []

    function randomInteger(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min
    }

    function setRandomStartPos(theBlock) {
        theBlock.y = -(cellSize * randomInteger(3, 12) * 2)
        theBlock.x = randomInteger(0, cellCount + 4) * cellSize
    }

    Image {
        id: startImage
        anchors.centerIn: parent
        width: parent.width
        height: parent.width
        source: "../resources/start.svg"
        z: 200
    }

    IBlock {
        id: iBlock
        property int freq: 3
        property int tick: 0
    }
    TBlock {
        id: tBlock
        property int freq: 3
        property int tick: 0
    }
    JBlock {
        id: jBlock
        property int freq: 4
        property int tick: 0
    }
    LBlock {
        id: lBlock
        property int freq: 4
        property int tick: 0
    }
    OBlock {
        id: oBlock
        property int freq: 5
        property int tick: 0
    }
    SBlock {
        id: sBlock
        property int freq: 5
        property int tick: 0
    }
    ZBlock {
        id: zBlock
        property int freq: 6
        property int tick: 0
    }

    Component.onCompleted: {
        blocks.push(iBlock, tBlock, jBlock, lBlock, oBlock, sBlock, zBlock)
        blocks.forEach(block => setRandomStartPos(block))
    }

    Timer {
        id: ticker
        running: true
        repeat: true
        interval: 1000 / 60
        onTriggered: {
            blocks.forEach(block => {
                               block.tick = block.tick + 1
                               if (block.tick >= block.freq) {
                                   block.y += 1
                                   if (block.y > parent.height) {
                                       setRandomStartPos(block)
                                   }
                                   block.tick = 0
                               }
                           })
        }
    }
}
