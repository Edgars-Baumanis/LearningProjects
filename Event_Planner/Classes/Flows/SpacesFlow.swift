//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {
    
    var logoutPressed: (()->Void)?
    var cellPressed: (()-> Void)?
    private var rootController: UITabBarController?
    private var userService: PUserService?
    
    init (with rootController: UITabBarController, userService: PUserService?) {
        self.rootController = rootController
        self.userService = userService
    }
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: Strings.SpacesSB.rawValue, bundle: Bundle.main)
    }()
    
    private lazy var joinVC: JoinASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: JoinASpaceController.self)) as? JoinASpaceController
    }()
    
    private lazy var spacesVC: MySpacesVC? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: MySpacesVC.self)) as? MySpacesVC
    }()
    
    private lazy var createVC: CreateASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: CreateASpaceController.self)) as? CreateASpaceController
    }()

    func start() {
        guard let vc = spacesVC else {return}
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        initiateSecondVC()
        let viewModel = MySpacesModel(userService: userService)
        viewModel.signingOut = { [weak self] in
            self?.logoutPressed?()
        }
        viewModel.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
        viewModel.cellPressed = { [weak self] in
            self?.cellPressed?()
        }
        vc.viewModel = viewModel
        rootController?.viewControllers = [vc, joinVC] as? [UIViewController]

    }
    
    private func initiateSecondVC() {
        guard let vc = joinVC else {return}
        let viewModel = JoinASpaceModel(userService: userService)
        viewModel.rightEntry = { [weak self] in
            self?.cellPressed?()
        }
        vc.tabBarItem = UITabBarItem(title: "Join", image: UIImage(named: "Magnifying_glass_icon"), tag: 2)
        vc.viewModel = viewModel
    }
    
    private func navigateToCreate() {
        guard let vc = createVC else {return}
        vc.viewModel = CreateASpaceModel(userService: userService)
        vc.viewModel?.backPressed = { [weak self] in
            self?.rootController?.dismiss(animated: true, completion: nil)
        }
        rootController?.present(vc, animated: true, completion: nil)
    }
}
