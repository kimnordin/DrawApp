//
//  Tool.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-08.
//

import Foundation
import UIKit

class Tools {
    var pencil = Pencil()
}

class Tool {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class Line: Tool {
    var width: CGFloat
    var opacity: CGFloat
    var points: [CGPoint]
    init(width: CGFloat = 2.0, opacity: CGFloat = 1.0, points: [CGPoint] = []) {
        self.width = width
        self.opacity = opacity
        self.points = points
        super.init(name: "Line", image: UIImage(systemName: "lineweight")!)
    }
}

class Pencil: Tool {
    var line: Line
    var color: UIColor = .black
    
    init(line: Line = Line(width: 2.0, opacity: 1.0, points: []), color: UIColor = .black) {
        self.line = line
        self.color = color
        super.init(name: "Pencil", image: UIImage(systemName: "pencil")!)
    }
}
