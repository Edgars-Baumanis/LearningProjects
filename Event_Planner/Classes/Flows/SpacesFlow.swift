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
    var cellPressed: ((_ space: SpaceDO)-> Void)?
    private var rootController: UITabBarController?
    private var userService: PUserService?
    private var spaceService: PSpacesService?
    
    init (with rootController: UITabBarController, userService: PUserService?, spaceService: PSpacesService?) {
        self.rootController = rootController
        self.userService = userService
        self.spaceService = spaceService
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
        let viewModel = MySpacesModel(userService: userService, spaceService: spaceService)
        viewModel.signingOut = { [weak self] in
            self?.logoutPressed?()
        }
        viewModel.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
        viewModel.navigateToMainFlow = { [weak self] space in
            self?.cellPressed?(space)
        }
        vc.viewModel = viewModel
        rootController?.viewControllers = [vc, joinVC] as? [UIViewController]
    }
    
    private func initiateSecondVC() {
        guard let vc = joinVC else {return}
        let viewModel = JoinASpaceModel(userService: userService, spaceService: spaceService)
        viewModel.rightEntry = { [weak self] space in
            self?.cellPressed?(space)
        }
        vc.tabBarItem = UITabBarItem(title: "Join", image: UIImage(named: "Magnifying_glass_icon"), tag: 2)
        vc.viewModel = viewModel
    }
    
    private func navigateToCreate() {
        guard let vc = createVC else {return}
        vc.viewModel = CreateASpaceModel(userService: userService, spaceService: spaceService)
        vc.viewModel?.backPressed = { [weak self] in
            self?.rootController?.dismiss(animated: true, completion: nil)
        }
        rootController?.present(vc, animated: true, completion: nil)
    }
}
