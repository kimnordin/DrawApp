//
//  BehaviourTabController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-08.
//

import UIKit

class BehaviourTabController: UITabBarController, UITabBarControllerDelegate {
    var sender: CanvasController? {
        didSet {
            if let typeVc = self.viewControllers?[0] as? TypeController {
                typeVc.canvasController = sender
            }
//            if let lineVc = self.viewControllers?[1] as? AppearanceController {
//                lineVc.canvasController = sender
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = sender?.selectedTabIndex.1 ?? 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        sender?.selectedTabIndex.1 = tabBarIndex
    }
}

