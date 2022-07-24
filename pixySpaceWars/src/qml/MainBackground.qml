import QtQuick
import QtQuick.Shapes

Shape {
    id: background
    ShapePath {
        PathLine { x: start.width + 1; y: 0 }
        PathLine { x: start.width + 1; y: start.height + 1 }
        PathLine { x: 0; y: start.height+ 1 }

        strokeColor: "transparent"
        
        fillGradient: RadialGradient {
            centerX: start.width / 2; centerY: start.height / 2
            centerRadius: start.width * 0.66
            focalX: centerX; focalY: centerY
            GradientStop { position: 0; color: "#505050" }
            GradientStop { position: 1; color: "#000000" }
        }
    }
}