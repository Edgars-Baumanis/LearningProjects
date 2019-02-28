//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {

    private var appWindow: UIWindow
    init (with window: UIWindow) {
        appWindow = window
    }
    
    // Create constant, better if enum "Main"
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var tabbar: MainTabbarController? {
        return mainSB.instantiateViewController(withIdentifier: MainTabbarController.className) as? MainTabbarController
    }
    
    func start() {
        guard let vc = tabbar else { return }
        let rootController = UINavigationController(rootViewController: vc)
        appWindow.rootViewController = rootController
        appWindow.makeKeyAndVisible()
        // init whole tabbar here
        
    }
}


