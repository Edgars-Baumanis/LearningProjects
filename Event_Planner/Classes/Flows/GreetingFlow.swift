//
//  GreetingFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingFlow: FlowController {
    
    private var rootController: UINavigationController?
    private let appWindow: UIWindow
    
    var signInPressed: (()->Void)?

    init(with window: UIWindow) {
        appWindow = window
    }
    
    private lazy var greetingSB: UIStoryboard = {
        return UIStoryboard(name: "Greeting", bundle: Bundle.main)
    }()
    
    private var greetingViewController: GreetingVC? {
        return greetingSB.instantiateViewController(withIdentifier: "GreetingVC") as? GreetingVC
    }
    
    func start() {
        guard let vc = greetingViewController else { return }
        rootController = UINavigationController(rootViewController: vc)
        appWindow.rootViewController = rootController
        appWindow.makeKeyAndVisible()
        let viewModel = GreetingModel()
        viewModel.signInPressed = { [weak self] in
            self?.navigateToLogin()
        }
        viewModel.signUpPressed = { [weak self] in
            self?.navigateToRegister()
        }
        vc.viewModel = viewModel
    }
    
    
    private var loginVC: LoginVC? {
        return greetingSB.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    }
    
    func navigateToLogin() {
        guard let vc = loginVC else { return }
        rootController?.pushViewController(vc, animated: true)
        vc.viewModel = LoginModel()
        vc.viewModel?.loggedIn = { [weak self] in
            self?.signInPressed?()
        }
    }
    
    private var registerVC: SignUpVC? {
        return greetingSB.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
    }
    
    func navigateToRegister() {
        guard let vc = registerVC else { return }
        rootController?.pushViewController(vc, animated: true)
        vc.viewModel = SignUpModel()
        vc.viewModel?.signUpPressed = { [weak self] in
            self?.navigateToLogin()
        }
    }
}

