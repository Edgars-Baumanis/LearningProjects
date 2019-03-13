//
//  GreetingFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingFlow: FlowController {
    
    private var rootController: UITabBarController?
    private var userService: PUserService?
    var navigateToSpaces: (()->Void)?
    

    init(with rootController: UITabBarController, userService: PUserService?) {
        self.rootController = rootController
        self.userService = userService
    }
    
    private lazy var greetingSB: UIStoryboard = {
        return UIStoryboard(name: Strings.greetingSB.rawValue, bundle: Bundle.main)
    }()
    
    private var greetingViewController: GreetingVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: GreetingVC.self)) as? GreetingVC
    }
    
    func start() {
        guard let vc = greetingViewController else { return }
        rootController?.present(vc, animated: false, completion: nil)
        let viewModel = GreetingModel()
        viewModel.signInPressed = { [weak self] in
            self?.rootController?.dismiss(animated: false, completion: nil)
            self?.navigateToLogin()
        }
        viewModel.signUpPressed = { [weak self] in
            self?.rootController?.dismiss(animated: false, completion: nil)
            self?.navigateToRegister()
        }
        vc.viewModel = viewModel
    }
    
    private var loginVC: LoginVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC
    }
    
    private func navigateToLogin() {
        guard let vc = loginVC else { return }
        rootController?.present(vc, animated: false, completion: nil)
        let viewModel = LoginModel(userService: userService)
       
        viewModel.loggedIn = { [weak self] in
            guard let `self` = self else { return }
            self.rootController?.dismiss(animated: true, completion: nil)
            self.navigateToSpaces?()
        }
        viewModel.backPressed = {
            self.rootController?.dismiss(animated: false, completion: nil)
            self.start()
        }
        vc.viewModel = viewModel
    }
    
    private var registerVC: SignUpVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC
    }
    
    private func navigateToRegister() {
        guard let vc = registerVC else { return }
        rootController?.present(vc, animated: false, completion: nil)
        let viewModel = SignUpModel(userService: userService)
        viewModel.signUpPressed = { [weak self] in
            self?.rootController?.dismiss(animated: false, completion: nil)
            self?.navigateToSpaces?()
        }
        viewModel.backPressed = {
            self.rootController?.dismiss(animated: false, completion: nil)
            self.start()
        }
        vc.viewModel = viewModel
    }
}

