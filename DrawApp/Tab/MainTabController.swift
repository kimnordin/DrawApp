//
//  MainTabController.swift
//  DrawApp
//
//  Created by Kim Nordin on 2021-11-07.
//

import UIKit

class MainTabController: UITabBarController, UITabBarControllerDelegate {
    var sender: CanvasController? {
        didSet {
            if let controllers = self.viewControllers {
                for vc in controllers {
                    if let styleTab = vc as? StyleTabController {
                        styleTab.sender = sender
                    }
                    if let behaviourTab = vc as? BehaviourTabController {
                        behaviourTab.sender = sender
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = sender?.selectedTabIndex.0 ?? 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        sender?.selectedTabIndex.0 = tabBarIndex
    }
}
