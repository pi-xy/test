import QtQuick

Rectangle {
    id: scoreRect
    visible: false
    anchors.fill: parent
    color: "transparent"

    FontLoader { id: fontloaderAnton; source: "../fonts/Anton-Regular.ttf" }

    property int score : 0

    property bool isHighScore: false

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function formatScore(score) {
        var s = score.toString().padStart(9, '0')
        if (isHighScore) {
            s+= ""
        } 
        return s
    }

    function updateScore(newScore) {
        isHighScore = false
        score += newScore
    }

    function updateHiScore(newScore) {
        isHighScore = true
        score += newScore
    }

    function resetScore() {
        isHighScore = false
        score = 0
    }

    Text {
        id: scoreText
        visible: fontloaderAnton.status == FontLoader.Ready
        text: formatScore(score)
        color: isHighScore ? "#ffffff" : "#ffffff"
        opacity: 1
        anchors.left: parent.left
        anchors.leftMargin: canvas.width * 0.04
        
        y: canvas.width * 0.045
        
        font.family: fontloaderAnton.name
        font.pixelSize: scoreRect.width * 0.05
        font.letterSpacing: (scoreRect.width * 0.05) * 0.15
    }
}