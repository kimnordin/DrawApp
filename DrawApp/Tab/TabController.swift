//
//  TabController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-07.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {
    var sender: CanvasController? {
        didSet {
            if let colorVc = self.viewControllers?[0] as? ColorController {
                colorVc.canvasController = sender
            }
            if let lineVc = self.viewControllers?[1] as? LineController {
                lineVc.canvasController = sender
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = sender?.selectedTabIndex ?? 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        sender?.selectedTabIndex = tabBarIndex
    }
}
