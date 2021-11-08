//
//  SubTabController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-08.
//

import UIKit

class StyleTabController: UITabBarController, UITabBarControllerDelegate {
    var sender: CanvasController? {
        didSet {
            if let controllers = self.viewControllers {
                for vc in controllers {
                    if let colorVc = vc as? ColorController {
                        colorVc.canvasController = sender
                    }
                    if let appearanceVc = vc as? AppearanceController {
                        appearanceVc.canvasController = sender
                    }
                }
            }
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
