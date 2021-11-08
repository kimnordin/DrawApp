//
//  CanvasView.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-04.
//

import UIKit

struct TouchDrawColor {
    var color: UIColor
    var width: CGFloat
    var opacity: CGFloat
    var points: [CGPoint]?
    
    init(color: UIColor, width: CGFloat, opacity: CGFloat, points: [CGPoint]) {
        self.color = color
        self.width = width
        self.opacity = opacity
        self.points = points
    }
}

class CanvasView: UIView {
    
    var linesCallback: ((_ empty: Bool) -> Void)?
    var lines = [TouchDrawColor]() {
        didSet {
            linesCallback?(lines.isEmpty)
        }
    }

    var pencil: Pencil = Pencil()
    
    func clearCanvas() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undoDraw() {
        if lines.count > 0 {
            _ = lines.popLast()
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.withAlphaComponent(line.opacity).cgColor)
            context.setLineWidth(line.width)
            context.setLineCap(.round)
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    // Started Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchDrawColor(color: pencil.color, width: pencil.line.width, opacity: pencil.line.opacity, points: []))
    }
    
    // Is Touching and Moving
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else { return }
        guard var lastPoint = lines.popLast() else { return } // Last tapped point
        
        lastPoint.points?.append(touch)
        lastPoint.color = pencil.color
        lastPoint.width = pencil.line.width
        lastPoint.opacity = pencil.line.opacity
        lines.append(lastPoint)
        
        setNeedsDisplay() // Calls draw() function
    }
}
