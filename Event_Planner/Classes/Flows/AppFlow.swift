//
//  AppFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase
class AppFlow: FlowController {
    
    fileprivate var window: UIWindow
    fileprivate var rootController: UITabBarController?
    fileprivate var childFlow: FlowController?
    fileprivate var userService: PUserService?
    fileprivate var mainRootController: UINavigationController?
    
    private var tabbar: MainTabbarController? = {
        let tabbar = MainTabbarController()
        return tabbar
    }()

    private var navController: NavController? = {
        let navController = NavController()
        return navController
    }()
    
    init(with window: UIWindow) {
        self.window = window
        rootController = tabbar
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        userService = DumbUserService()
    }

    func start() {
        if Auth.auth().currentUser != nil {
            self.navigateToSpacesFlow()
        } else {
            self.navigateToGreetingFlow()
        }
    }

    private func navigateToGreetingFlow() {
        guard let tabbar = rootController else {return}
        let greetingFlow = GreetingFlow(with: tabbar, userService: userService)
        greetingFlow.start()
        greetingFlow.navigateToSpaces = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        childFlow = greetingFlow
    }

    private func navigateToSpacesFlow() {
        guard let tabbar = rootController else {return}
        let spacesFlow = SpacesFlow(with: tabbar, userService: userService)
        spacesFlow.start()
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
        spacesFlow.cellPressed = { [weak self] in
            self?.navigateToMainFlow()
        }
    }

    private func navigateToMainFlow() {
        mainRootController = navController
        window.rootViewController = mainRootController
        guard let mainRC = mainRootController else {return}
        let mainFlow = MainFlow(with: mainRC)
        mainFlow.start()
    }

}
