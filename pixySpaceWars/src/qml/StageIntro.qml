import QtQuick

Rectangle {
    id: stageIntro
    visible: false
    anchors.fill: parent
    color: "transparent"

    signal didFinish

    FontLoader { id: fontloaderAnton; source: "../fonts/Anton-Regular.ttf" }

    Component.onCompleted: {
        if (parent.objectName != "Main") {
            startAnimation()
        }
    }

    function startAnimation() {
        stageIntro.visible = true
        animation.running = true
    }

    Text {
        id: letsGo
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.centerIn: stageIntro
        text: "LET'S GO!"
        font.letterSpacing: (stageIntro.width * 0.170) * 0.04
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: stageIntro.width * 0.25
        opacity: 0.85
        scale: 0
    }

    SequentialAnimation {
        id: animation

        PauseAnimation { duration: 500 }

        ParallelAnimation {
            PropertyAnimation {
                id: letsGoFadeOutAnimation
                target: letsGo
                property: "opacity"
                from: 0
                to: 0.85
                duration: 500
            }

            PropertyAnimation {
                id: letsGoScaleOutAnimation
                target: letsGo
                property: "scale"
                from: 0
                to: 1
                duration: 375
                easing.type: Easing.InCirc
            }
        }

        PauseAnimation { duration: 250 }

        PropertyAnimation {
            id: letsGoFadeOutAnimation2
            target: letsGo
            property: "opacity"
            from: 0.85
            to: 0
            duration: 375
        }

        ScriptAction { script: didFinish() }        
    }
}