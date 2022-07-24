import QtQuick

Rectangle {
    id: stageOutro
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
        letsGo.scale = 0
        letsGo.opacity = 0.85
        stageOutro.visible = true
        animation.running = true
    }

    Text {
        id: letsGo
        visible: fontloaderAnton.status == FontLoader.Ready
        anchors.centerIn: stageOutro
        text: "STAGE OVER!"
        font.letterSpacing: (stageOutro.width * 0.170) * 0.04
        color: "#ffffff"
        font.family: fontloaderAnton.name
        font.pixelSize: stageOutro.width * 0.18
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