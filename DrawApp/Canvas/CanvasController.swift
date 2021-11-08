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
    
    var selectedTabIndex: Int = 0
    var selectedColor = UIColor.black {
        didSet {
            canvasView.strokeColor = selectedColor
            colorButton.backgroundColor = selectedColor
        }
    }
    
    var selectedWeight: CGFloat = 2.0 {
        didSet {
            canvasView.strokeWidth = selectedWeight
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toolBar" {
            guard let destination = segue.destination as? TabController else {return}
            destination.sender = self
        }
    }
    
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
