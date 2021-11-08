//
//  ViewController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-04.
//

import UIKit

class CanvasController: UIViewController {
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var toolButton: UIButton!
    @IBOutlet weak var colorWeightPreview: UIButton!
    @IBOutlet weak var canvasView: CanvasView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var selectedColor = UIColor.black {
        didSet {
            tools.pencil.color = selectedColor
            canvasView.pencil.color = tools.pencil.color
            colorWeightPreview.backgroundColor = tools.pencil.color
        }
    }
    
    var selectedOpacity: CGFloat = 1.0 {
        didSet {
            tools.pencil.line.opacity = selectedOpacity
            canvasView.pencil.line.opacity = selectedOpacity
            styleToolButton()
        }
    }
    
    var selectedWeight: CGFloat = 5.0 {
        didSet {
            tools.pencil.line.width = selectedWeight
            canvasView.pencil.line.width = selectedWeight
            styleToolButton()
        }
    }
    
    var tools = Tools()
    
    var selectedTabIndex: (Int, Int) = (1, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedColor = .label
        
        toolButton.backgroundColor = .clear
        toolButton.layer.cornerRadius = toolButton.frame.width/2
        toolButton.layer.borderWidth = 3
        toolButton.layer.borderColor = UIColor.label.cgColor
        
        styleToolButton()
        canvasView.linesCallback = { (empty) -> Void in
            self.styleUndoButton(canUndo: empty)
        }
    }
    
    func styleToolButton() {
        if selectedWeight > 5 {
            heightConstraint.constant = selectedWeight
            widthConstraint.constant = selectedWeight
            colorWeightPreview.layer.cornerRadius = selectedWeight/2
        }
        else {
            heightConstraint.constant = 5
            widthConstraint.constant = 5
            colorWeightPreview.layer.cornerRadius = 5/2
        }
        colorWeightPreview.backgroundColor = colorWeightPreview.backgroundColor?.withAlphaComponent(selectedOpacity)
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
    
    func onOpacityChange(opacity: CGFloat) {
        selectedOpacity = opacity
    }
    
    func onWeightChange(weight: CGFloat) {
        selectedWeight = weight
    }
}
