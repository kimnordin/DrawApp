//
//  LineController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-07.
//

import UIKit

class AppearanceController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var selectedOpacity: CGFloat?
    var selectedWeight: CGFloat?
    var canvasController: CanvasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let canvas = canvasController {
            selectedWeight = canvas.tools.pencil.line.width
            selectedOpacity = canvas.tools.pencil.line.opacity
        }
        updateReceiver()
    }
    
    override func viewDidLayoutSubviews() {
        backView.roundCorners([.topLeft, .topRight], radius: 35)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let opacity = CGFloat(opacitySlider.value)
        let weight = CGFloat(weightSlider.value)
        selectedOpacity = opacity
        selectedWeight = weight
        updateSender()
    }
    
    // Update this View to match the Parents current Line
    func updateReceiver() {
        if let weight = selectedWeight {
            updateSliders(weight: weight)
        }
        if let opacity = selectedOpacity {
            updateSliders(opacity: opacity)
        }
    }
    
    // Update the Parents Line to match this Views Line
    func updateSender() {
        if let weight = selectedWeight {
            canvasController?.onWeightChange(weight: weight)
        }
        if let opacity = selectedOpacity {
            canvasController?.onOpacityChange(opacity: opacity)
        }
    }

    // Update the Slider Views to match the current value
    func updateSliders(weight: CGFloat? = nil, opacity: CGFloat? = nil) {
        if let weight = weight {
            weightSlider.value = Float(weight)
        }
        if let opacity = opacity {
            opacitySlider.value = Float(opacity)
        }
    }
}
