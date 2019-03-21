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

    private var tabbar: MainTabbarController? = {
        let tabbar = MainTabbarController()
        return tabbar
    }()

    

    init(with window: UIWindow) {
        self.window = window

        window.makeKeyAndVisible()
        userService = UserService()
    }

    func start() {
        rootController = tabbar
        if Auth.auth().currentUser != nil {
            guard
                let userID = Auth.auth().currentUser?.uid,
                let email = Auth.auth().currentUser?.email
                else { return }
            self.userService?.user = User(email: email, userID: userID)
            self.navigateToSpacesFlow()
        } else {
            self.navigateToGreetingFlow()
        }
    }

    private func navigateToGreetingFlow() {
        window.rootViewController = rootController
        guard let tabbar = rootController else {return}
        let greetingFlow = GreetingFlow(with: tabbar, userService: userService)
        greetingFlow.start()
        greetingFlow.navigateToSpaces = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        childFlow = greetingFlow
    }

    private func navigateToSpacesFlow() {
        window.rootViewController = rootController
        guard let tabbar = rootController else {return}
        let spacesFlow = SpacesFlow(with: tabbar, userService: userService)
        spacesFlow.start()
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
        spacesFlow.cellPressed = { [weak self] spaceName in
            self?.navigateToMainFlow(spaceName: spaceName)
        }
    }

    private func navigateToMainFlow(spaceName: String) {
        guard let tabbar = rootController else { return }
        let mainFlow = MainFlow(with: tabbar, with: spaceName, with: userService)
        mainFlow.start()
        mainFlow.backPressed = { [weak self] in
            self?.start()
        }
        childFlow = mainFlow
    }
}
