import QtQuick

Rectangle {
    id: lives
    visible: false
    anchors.right : parent.right

    property alias life1: life1
    property alias life2: life2
    property alias life3: life3


    ShipIcon {
        id: life1
        anchors.right: parent.right
        anchors.rightMargin: canvas.width * 0.05
        y: canvas.width * 0.05
        width: canvas.width * 0.060
        height: canvas.width * 0.060
        engineAnimation.running: false
    }

    ShipIcon {
        id: life2
        anchors.right: life1.left
        anchors.rightMargin: canvas.width * 0.01
        y: canvas.width * 0.05
        width: canvas.width * 0.060
        height: canvas.width * 0.060
        engineAnimation.running: false
    }

    ShipIcon {
        id: life3
        anchors.right: life2.left
        anchors.rightMargin: canvas.width * 0.01
        y: canvas.width * 0.05
        width: canvas.width * 0.060
        height: canvas.width * 0.060
        engineAnimation.running: false
    }
}