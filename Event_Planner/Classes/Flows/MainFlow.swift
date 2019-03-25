//
//  MainFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainFlow: FlowController {

    var backPressed: (()-> Void)?

    private var rootController: UINavigationController?
    private var rootTabbar: UITabBarController?
    private var space: Space?
    private var userServices: PUserService?
    private var childFlow: FlowController?

    init(with tabbar: UITabBarController, with space: Space?, with userServices: PUserService?) {
        self.rootTabbar = tabbar
        self.space = space
        self.userServices = userServices
    }

    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.MainSB.rawValue, bundle: Bundle.main)
    }()

    private var mainViewController: MainViewController? {
        return mainSB.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as? MainViewController
    }

    func start() {
        guard let vc = mainViewController else {return}
        

        let viewModel = MainModel()

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

        viewModel.backPressed = { [weak self] in
            self?.rootTabbar?.dismiss(animated: true, completion: nil)
            self?.backPressed?()
        }
        viewModel.space = self.space

        vc.viewModel = viewModel

        rootController = UINavigationController(rootViewController: vc)
        guard let navController = rootController else { return }
        rootTabbar?.present(navController, animated: true, completion: nil)
    }

    private func navigateToTasksFlow() {
        let tasksFlow = TasksFlow(spaceKey: space?.key, rootController: rootController, userService: userServices)
        tasksFlow.start()
        childFlow = tasksFlow
    }

    private func navigateToChatFlow() {
        let chatFlow = ChatsFlow(rootController: rootController, spaceKey: space?.key, userServices: userServices)
        chatFlow.start()
        childFlow = chatFlow
    }

    private func navigateToIdeaFlow() {
        let ideaFlow = IdeasFlow(rootController: rootController, spaceKey: space?.key, userServices: userServices)
        ideaFlow.start()
        childFlow = ideaFlow
    }

    private func navigateToBudgetFlow() {
        let budgetFlow = BudgetFlow(rootController: rootController, spaceKey: space?.key)
        budgetFlow.start()
        childFlow = budgetFlow
    }
}

