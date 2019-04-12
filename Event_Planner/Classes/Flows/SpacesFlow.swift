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
    var reloadSpaces: (() -> Void)?
    var rootController: UINavigationController?
    private var userService: PUserService?
    private var spaceService: PSpacesService?
    private var ideaService: PIdeaService?
    private var chatService: PChatService?
    private var taskService: PTaskService?
    private var budgetService: PBudgetService?
    private var childFlow: FlowController?
    private var spacesVC: MySpacesVC?
    
    init (rootController: UINavigationController?, userService: PUserService?, spaceService: PSpacesService?, ideaService: PIdeaService?, chatService: PChatService?, taskService: PTaskService?, budgetService: PBudgetService?,  spacesVC: MySpacesVC?) {
        self.rootController = rootController
        self.userService = userService
        self.spaceService = spaceService
        self.ideaService = ideaService
        self.chatService = chatService
        self.taskService = taskService
        self.budgetService = budgetService
        self.spacesVC = spacesVC
    }
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: Strings.SpacesSB.rawValue, bundle: Bundle.main)
    }()
    
    private lazy var joinVC: JoinASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: JoinASpaceController.self)) as? JoinASpaceController
    }()
    
    private lazy var createVC: CreateASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: CreateASpaceController.self)) as? CreateASpaceController
    }()

    func start() {
        let spacesViewModel = MySpacesModel(userService: userService, spaceService: spaceService)
        spacesViewModel.signingOut = { [weak self] in
            self?.spacesVC?.viewModel = nil
            self?.spacesVC?.mySpaces.reloadData()
            self?.logoutPressed?()
        }
        spacesViewModel.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
        spacesViewModel.navigateToMainFlow = { [weak self] space in
            self?.navigateToMainFlow(space: space)
        }
        spacesViewModel.joinPressed = { [weak self] in
            self?.navigateToJoin()
        }
        reloadSpaces = {
            spacesViewModel.reloadSpaces()
        }
        spacesVC?.viewModel = spacesViewModel
    }

    private func navigateToJoin() {
        guard let joinVC = joinVC else {return}
        let joinViewModel = JoinASpaceModel(userService: userService, spaceService: spaceService)
        joinViewModel.rightEntry = { [weak self] space in
            self?.rootController?.dismiss(animated: true)
        }
        joinViewModel.backPressed = { [weak self] in
            self?.rootController?.dismiss(animated: true)
        }
        joinVC.viewModel = joinViewModel
        rootController?.present(joinVC, animated: true)
    }

    private func navigateToCreate() {
        guard let vc = createVC else {return}
        vc.viewModel = CreateASpaceModel(userService: userService, spaceService: spaceService)
        vc.viewModel?.backPressed = { [weak self] in
            self?.rootController?.dismiss(animated: true)
        }
        rootController?.present(vc, animated: true)
    }

    private func navigateToMainFlow(space: SpaceDO?) {
        guard let navController = rootController else { return }
        let mainFlow = MainFlow(rootController: navController, userServices: userService, ideaService: ideaService, space: space, chatService: chatService, taskService: taskService, budgetService: budgetService)
        mainFlow.start()
        childFlow = mainFlow
    }
}
