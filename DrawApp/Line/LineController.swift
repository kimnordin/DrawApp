//
//  LineController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-07.
//

import UIKit

class LineController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var weightSlider: UISlider!
    
    var selectedWeight: CGFloat?
    var canvasController: CanvasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let canvasWeight = canvasController?.pencil.line.width {
            selectedWeight = canvasWeight*100
        }
        updateReceiverWeight()
    }
    
    override func viewDidLayoutSubviews() {
        backView.roundCorners([.topLeft, .topRight], radius: 35)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let weight = CGFloat(sender.value)
        selectedWeight = weight
        updateSenderWeight()
    }
    
    // Update this View to match the Parents current selectedWeight
    func updateReceiverWeight() {
        updatePreview()
        if let weight = selectedWeight {
            updateSliders(weight: weight)
        }
    }
    
    // Update the Parents line-weight to match this Views selectedWeight
    func updateSenderWeight() {
        if let weight = selectedWeight {
            canvasController?.onWeightChange(weight: weight/100)
        }
    }
    
    // Update the Preview View to match the selectedWeight
    func updatePreview() {

    }
    
    // Update the Slider Views to match the selectedWeight
    func updateSliders(weight: CGFloat?) {
        if let weight = weight {
            weightSlider.value = Float(weight)
        }
    }
}
