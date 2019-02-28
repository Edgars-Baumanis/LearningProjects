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
    
    fileprivate var childFlow: FlowController?
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    private func navigateToSpacesFlow() {
        let spacesFlow = SpacesFlow(with: window)
        spacesFlow.start()
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
    }
    
    private func navigateToGreetingFlow() {
        let greetingFlow = GreetingFlow(with: window)
        greetingFlow.start()
        greetingFlow.signInPressed = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        childFlow = greetingFlow
    }
    
    func start() {
        if Auth.auth().currentUser != nil {
            self.navigateToSpacesFlow()
        } else {
            self.navigateToGreetingFlow()
        }
    }
}
