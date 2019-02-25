//
//  AppFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

protocol FlowController {
    var window: UIWindow?? {get}
    func start()
}

extension FlowController {
    var window: UIWindow?? {
        return UIApplication.shared.delegate!.window
    }
}

class AppFlow: FlowController {
    fileprivate var childFlow: FlowController?
    
    init() {
        SignInPressed()
        SignUpPressed()
    }
    
    private func SignInPressed() {
        NotificationCenter.default.addObserver(self, selector: #selector(toLogin), name: Notification.Name("SigninPressed"), object: nil)
    }
    
    private func SignUpPressed() {
        NotificationCenter.default.addObserver(self, selector: #selector(toReg), name: Notification.Name("SignUpPressed"), object: nil)
    }
    
    @objc func toLogin() {
        let loginFlow = LoginFlow()
        window??.rootViewController = loginFlow.rootController
        loginFlow.start()
        childFlow = loginFlow
    }
    
    @objc func toMain() {
        
    }
    
    @objc func toReg() {
        let regFlow = RegistrationFlow()
        window??.rootViewController = regFlow.rootController
        regFlow.start()
        childFlow = regFlow
    }
    
    func start() {
        let greetingFlow = GreetingFlow()
        window??.rootViewController = greetingFlow.rootController
        greetingFlow.start()
        childFlow = greetingFlow
    }
}
