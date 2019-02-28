//
//  AppFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AppFlow: FlowController {
    
    private var window: UIWindow

    fileprivate var childFlow: FlowController?
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    private func navigateToMainFlow() {
        let spacesFlow = SpacesFlow(with: window)
        spacesFlow.start()
        childFlow = spacesFlow
    }
    
    func start() {
        let greetingFlow = GreetingFlow(with: window)
        greetingFlow.start(with: {
            self.navigateToMainFlow()
        })
        childFlow = greetingFlow
    }
}
