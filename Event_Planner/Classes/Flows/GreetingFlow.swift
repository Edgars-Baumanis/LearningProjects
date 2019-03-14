//
//  GreetingFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingFlow: FlowController {
    
    private var tabbar: UITabBarController?
    private var userService: PUserService?
    private var rootController: UINavigationController?
    var navigateToSpaces: (()->Void)?

    init(with tabbar: UITabBarController, userService: PUserService?) {
        self.tabbar = tabbar
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
        let viewModel = GreetingModel()
        viewModel.signInPressed = { [weak self] in
            self?.navigateToLogin()
        }
        viewModel.signUpPressed = { [weak self] in
            self?.navigateToRegister()
        }
        vc.viewModel = viewModel
        rootController = UINavigationController(rootViewController: vc)
        guard let navController = rootController else { return }
        tabbar?.present(navController, animated: false, completion: nil)

    }
    
    private var loginVC: LoginVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC
    }
    
    private func navigateToLogin() {
        guard let vc = loginVC else { return }
        rootController?.pushViewController(vc, animated: true)
        let viewModel = LoginModel(userService: userService)
       
        viewModel.loggedIn = { [weak self] in
            guard let `self` = self else { return }
            self.navigateToSpaces?()
            self.tabbar?.dismiss(animated: true, completion: nil)
        }
        viewModel.backPressed = {
            self.start()
        }
        vc.viewModel = viewModel
    }
    
    private var registerVC: SignUpVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC
    }
    
    private func navigateToRegister() {
        guard let vc = registerVC else { return }
        rootController?.pushViewController(vc, animated: true)
        let viewModel = SignUpModel(userService: userService)
        viewModel.signUpPressed = { [weak self] in
            self?.tabbar?.dismiss(animated: true, completion: nil)
            self?.navigateToSpaces?()
        }
        viewModel.backPressed = {
            self.start()
        }
        vc.viewModel = viewModel
    }
}

