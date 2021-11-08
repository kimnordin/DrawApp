//
//  ColorController.swift
//  GoDogs
//
//  Created by Kim Nordin on 2020-10-01.
//  Copyright © 2020 kim. All rights reserved.
//

import UIKit

class ColorController: UIViewController {
   
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var stringColorArray = [String]()
    var colorArray = [UIColor]()
    var selectedColor: UIColor?
    var canvasController: CanvasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorCollection.dataSource = self
        self.colorCollection.delegate = self
        
        stringColorArray = self.fetchColorDataArray()
        colorCollection.layer.cornerRadius = 5
        colorPreview.layer.cornerRadius = 15.0
        colorPreview.layer.borderWidth = 3
        colorPreview.layer.borderColor = UIColor.label.cgColor
        
        for hex in stringColorArray {
            colorArray.append(UIColor.init(hexString: hex))
        }
        
        selectedColor = canvasController?.selectedColor
        updateReceiverColors()
        
        let nib = UINib(nibName: "ColorCollectionCell", bundle: nil)
        colorCollection.register(nib, forCellWithReuseIdentifier: "ColorCollectionCell")
    }
    
    override func viewDidLayoutSubviews() {
        backView.roundCorners([.topLeft, .topRight], radius: 35)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        selectedColor = UIColor(red:red/255, green:green/255, blue:blue/255, alpha:1.0)
        updatePreview()
        updateSenderColor()
    }
    
    // Update this View to match the Parents current selectedColor
    func updateReceiverColors() {
        updatePreview()
        updateSliders(color: selectedColor)
    }
    
    // Update the Parents color to match this Views selectedColor
    func updateSenderColor() {
        canvasController?.onColorChange(color: selectedColor ?? .black)
    }
    
    // Update the Preview View to match the selectedColor
    func updatePreview() {
        colorPreview.backgroundColor = selectedColor
    }
    
    // Update the Slider Views to match the selectedColor
    func updateSliders(color: UIColor?) {
        if let red = color?.rgb()?.red,
           let green = color?.rgb()?.green,
           let blue = color?.rgb()?.blue {
            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
        }
    }
    
    func fetchColorDataArray() -> [String] {
        if let path = Bundle.main.path(forResource: "Colors", ofType: "plist") {
            if let color = NSArray(contentsOfFile: path) {
                return color as! [String]
            }
        }
        return []
    }
}

extension ColorController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/17, height: collectionView.bounds.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = colorArray[indexPath.row]
        updateSliders(color: selectedColor)
        colorPreview.backgroundColor = selectedColor
        updateSenderColor()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionCell", for: indexPath) as! ColorCollectionCell
        let color = colorArray[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
}
