//
//  MainFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainFlow: FlowController {

    var navigateToSpacesFlow: (()-> Void)?

    private var rootController: UINavigationController?
    private var space: SpaceDO?
    private var userServices: PUserService?
    private var childFlow: FlowController?
    private var ideaService: PIdeaService?
    private var chatService: PChatService?
    private var taskService: PTaskService?
    private var budgetService: PBudgetService?
    private var mainService: PMainService?

    init(rootController: UINavigationController, userServices: PUserService?, ideaService: PIdeaService?, space: SpaceDO?, chatService: PChatService?, taskService: PTaskService?, budgetService: PBudgetService?, mainService: PMainService?) {
        self.rootController = rootController
        self.budgetService = budgetService
        self.ideaService = ideaService
        self.userServices = userServices
        self.space = space
        self.chatService = chatService
        self.taskService = taskService
        self.mainService = mainService
    }

    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.MainSB.rawValue, bundle: Bundle.main)
    }()

    private var mainViewController: MainViewController? {
        return mainSB.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as? MainViewController
    }

    private var eventUserController: EventUserController? {
        return mainSB.instantiateViewController(withIdentifier: String(describing: EventUserController.self)) as? EventUserController
    }

    func start() {
        guard let vc = mainViewController else {return}
        rootController?.navigationBar.prefersLargeTitles = true
        let viewModel = MainModel(mainService, userServices)

        viewModel.budgetPressed = { [weak self] in
            self?.navigateToBudgetFlow()
        }

        viewModel.chatPressed = { [weak self] in
            self?.navigateToChatFlow()
        }

        viewModel.ideasPressed = { [weak self] in
            self?.navigateToIdeaFlow()
        }

        viewModel.tasksPressed = { [weak self] in
            self?.navigateToTasksFlow()
        }

        viewModel.infoPressed = { [weak self] in
            self?.navigateToEventUsers()
        }

        viewModel.leaveSpace = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }

        viewModel.space = self.space

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTasksFlow() {
        let tasksFlow = TasksFlow(spaceKey: space?.key, rootController: rootController, userService: userServices, taskService: taskService)
        tasksFlow.start()
        childFlow = tasksFlow
    }

    private func navigateToChatFlow() {
        let chatFlow = ChatsFlow(rootController: rootController, space: space, userServices: userServices, chatService: chatService)
        chatFlow.start()
        childFlow = chatFlow
    }

    private func navigateToIdeaFlow() {
        let ideaFlow = IdeasFlow(rootController: rootController, spaceKey: space?.key, userServices: userServices, ideaService: ideaService)
        ideaFlow.start()
        childFlow = ideaFlow
    }

    private func navigateToBudgetFlow() {
        let budgetFlow = BudgetFlow(rootController: rootController, space: space, budgetService: budgetService, userService: userServices)
        budgetFlow.start()
        childFlow = budgetFlow
    }

    private func navigateToEventUsers() {
        guard let vc = eventUserController else { return }
        let viewModel = EventUserModel(space, mainService, userServices)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}

