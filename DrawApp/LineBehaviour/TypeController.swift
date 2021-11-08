//
//  TypeController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-08.
//

import UIKit

class TypeController: UIViewController {

    @IBOutlet weak var backView: UIView!
    var canvasController: CanvasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        backView.roundCorners([.topLeft, .topRight], radius: 35)
    }
}
