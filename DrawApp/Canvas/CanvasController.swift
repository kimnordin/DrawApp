//
//  ViewController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-04.
//

import UIKit

class CanvasController: UIViewController {
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var canvasView: CanvasView!
    
    var selectedTabIndex: (Int, Int) = (1, 0)
    
    var selectedColor = UIColor.black {
        didSet {
            pencil.color = selectedColor
            canvasView.pencil.color = pencil.color
            colorButton.backgroundColor = pencil.color
        }
    }
    
    var selectedWeight: CGFloat = 2.0 {
        didSet {
            pencil.line.width = selectedWeight
            canvasView.pencil.line.width = selectedWeight
        }
    }
    
    var pencil = Pencil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedColor = .label
        colorButton.layer.cornerRadius = colorButton.frame.width/2
        colorButton.layer.borderWidth = 3
        colorButton.layer.borderColor = UIColor.label.cgColor
        
        canvasView.linesCallback = { (empty) -> Void in
            self.styleUndoButton(canUndo: empty)
        }
    }
    
    func styleUndoButton(canUndo: Bool) {
        if canvasView.lines.isEmpty {
            undoButton.setSfImage("arrowshape.turn.up.left")
        }
        else {
            undoButton.setSfImage("arrowshape.turn.up.left.fill")
        }
    }
    
    @IBAction func toolButtonAction(_ sender: UIButton) {
        popController()
    }
    
    @IBAction func undoButtonAction(_ sender: UIButton) {
        canvasView.undoDraw()
    }
    
    func onColorChange(color: UIColor) {
        selectedColor = color
    }
    
    func onWeightChange(weight: CGFloat) {
        selectedWeight = weight
    }
}
