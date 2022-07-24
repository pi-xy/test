import QtQuick
import QtQuick.Shapes

Rectangle {
    id: start
    anchors.fill: parent
    color: "transparent"

    Component.onCompleted: {
        window.flashGreenButton()
    }

    function show() {
        spaceWarsTitle.opacity = 1
        spaceWarsTitle.scale = 1
        pressToStart.opacity = 1
        pressToStart.scale = 1
        flashPressStartAnimation.running = true
        start.visible = true
    }

    Connections {
        target: window

        function onRoundButtonPressed()
        {
            if (pressToStart.opacity == 0) { return }

             window.unFlashGreenButton()
            pressStartFadeOutAnimation.running = true
            titleFadeOutAnimation.running = true
            titleScaleOutAnimation.running = true
            flashPressStartAnimation.running = false
            pressToStart.opacity = 0
            main.startGame()
        }
    }

    Text {
        id: spaceWarsTitle
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.centerIn: start
        text: "SPACE WARS"
        font.letterSpacing: (start.width * 0.170) * 0.04
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: start.width * 0.170
        opacity: 0.85
        FontLoader { id: fontloaderAnton; source: "../fonts/Anton-Regular.ttf" }

        PropertyAnimation {
            id: titleFadeOutAnimation
            target: spaceWarsTitle
            property: "opacity"
            from: 1
            to: 0
            duration: 500
            running: false
        }

        PropertyAnimation {
            id: titleScaleOutAnimation
            target: spaceWarsTitle
            property: "scale"
            from: 1
            to: 0
            duration: 500
            running: false
            easing.type: Easing.InCirc
        }
    }

    Text {
        id: pressToStart
        visible: fontloaderRaleway.status == FontLoader.Ready
        y: start.height * 0.68
        anchors.horizontalCenter: start.horizontalCenter
        text: "PRESS START"
        color: "#ffffff"
        font.family: fontloaderRaleway.name
        font.pixelSize: width * 0.17

        SequentialAnimation {
            id: flashPressStartAnimation
            running: true
            loops: Animation.Infinite
            PropertyAnimation {
                target: pressToStart
                property: "opacity"
                from: 0
                to: 0.90
                duration: 1000
            }

            PropertyAnimation {
                target: pressToStart
                property: "opacity"
                from: 0.90
                to: 0
                duration: 1000
            }
        }
        PropertyAnimation {
            id: pressStartFadeOutAnimation
            target: spaceWarsTitle
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 1000
            running: false
        }
    }

    FontLoader { id: fontloaderRaleway; source: "../fonts/Raleway-Regular.ttf"}
}
