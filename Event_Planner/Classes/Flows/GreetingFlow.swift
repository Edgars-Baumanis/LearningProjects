//
//  GreetingFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingFlow: FlowController {
    
    var rootController: UINavigationController?
    private var userService: PUserService?
    var navigateToSpaces: (()->Void)?

    init(with rootController: UINavigationController?, userService: PUserService?) {
        self.rootController = rootController
        self.userService = userService
    }
    
    private lazy var greetingSB: UIStoryboard = {
        return UIStoryboard(name: Strings.greetingSB.rawValue, bundle: Bundle.main)
    }()

    private var greetingViewController: GreetingVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: GreetingVC.self)) as? GreetingVC
    }

    private var loginVC: LoginVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC
    }

    private var registerVC: SignUpVC? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC
    }

    private var forgotPasswordVC: ForgotPassword? {
        return greetingSB.instantiateViewController(withIdentifier: String(describing: ForgotPassword.self)) as? ForgotPassword
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
    }

    private func navigateToLogin() {
        guard let vc = loginVC else { return }
        rootController?.pushViewController(vc, animated: true)
        let viewModel = LoginModel(userService: userService)
       
        viewModel.loggedIn = { [weak self] in
            guard let `self` = self else { return }
            self.navigateToSpaces?()
            self.rootController?.dismiss(animated: true, completion: nil)
        }

        viewModel.forgotPassword = { [weak self] in
            self?.navigateToForgotPassword()
        }
        vc.viewModel = viewModel
    }
    
    private func navigateToRegister() {
        guard let vc = registerVC else { return }
        rootController?.pushViewController(vc, animated: true)
        let viewModel = SignUpModel(userService: userService)
        viewModel.navigateToSpaces = { [weak self] in
            self?.rootController?.dismiss(animated: true, completion: nil)
            self?.navigateToSpaces?()
        } 
        vc.viewModel = viewModel
    }

    private func navigateToForgotPassword() {
        guard let vc = forgotPasswordVC else { return }
        let viewModel = ForgorPasswordModel(userService: userService)
        viewModel.closePressed = { [weak self] in
            self?.rootController?.dismiss(animated: false, completion: nil)
        }
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overCurrentContext
        rootController?.present(vc, animated: false, completion: nil)
    }
}

