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
    private var rootController: UITabBarController?
    private var userService: PUserService?
    private var spaceService: PSpacesService?
    private var spacesNavController: UINavigationController?
    private var ideaService: PIdeaService?
    private var chatService: PChatService?
    private var taskService: PTaskService?
    private var budgetService: PBudgetService?
    private var childFlow: FlowController?
    
    init (rootController: UITabBarController, userService: PUserService?, spaceService: PSpacesService?, ideaService: PIdeaService?, chatService: PChatService?, taskService: PTaskService?, budgetService: PBudgetService?) {
        self.rootController = rootController
        self.userService = userService
        self.spaceService = spaceService
        self.ideaService = ideaService
        self.chatService = chatService
        self.taskService = taskService
        self.budgetService = budgetService
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
        guard let spacesVC = spacesVC else { return }
        spacesNavController = UINavigationController(rootViewController: spacesVC)
        spacesVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        let spacesViewModel = MySpacesModel(userService: userService, spaceService: spaceService)
        spacesViewModel.signingOut = { [weak self] in
            self?.logoutPressed?()
        }
        spacesViewModel.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
        spacesViewModel.navigateToMainFlow = { [weak self] space in
            self?.navigateToMainFlow(space: space)
        }
        spacesVC.viewModel = spacesViewModel

        guard let joinVC = joinVC else {return}
        let joinViewModel = JoinASpaceModel(userService: userService, spaceService: spaceService)
        joinViewModel.rightEntry = { [weak self] space in
            self?.navigateToMainFlow(space: space)
        }
        joinVC.tabBarItem = UITabBarItem(title: "Join", image: UIImage(named: "Magnifying_glass_icon"), tag: 2)
        joinVC.viewModel = joinViewModel
        rootController?.viewControllers = [spacesNavController, joinVC] as? [UIViewController]
    }

    private func navigateToCreate() {
        guard let vc = createVC else {return}
        vc.viewModel = CreateASpaceModel(userService: userService, spaceService: spaceService)
        vc.viewModel?.backPressed = { [weak self] in
            self?.spacesNavController?.popViewController(animated: true)
        }
        spacesNavController?.pushViewController(vc, animated: true)
    }

    private func navigateToMainFlow(space: SpaceDO?) {
        guard let navController = spacesNavController else { return }
        let mainFlow = MainFlow(rootController: navController, userServices: userService, ideaService: ideaService, space: space, chatService: chatService, taskService: taskService, budgetService: budgetService)
        mainFlow.start()
        childFlow = mainFlow
    }
}
