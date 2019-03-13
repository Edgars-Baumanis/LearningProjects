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
    private var tabbar: UITabBarController?
    private var spaceName: String?

    init(with tabbar: UITabBarController, with spaceName: String?) {
        self.tabbar = tabbar
        self.spaceName = spaceName
    }

    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.MainSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var budgetSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.BudgetSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var ideasSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.IdeasSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var chatsSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.ChatsSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var tasksSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TasksSB.rawValue, bundle: Bundle.main)
    }()

    private var mainViewController: MainViewController? {
        return mainSB.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as? MainViewController
    }

    private var ideasViewController: IdeasController? {
        return ideasSB.instantiateViewController(withIdentifier: String(describing: IdeasController.self)) as? IdeasController
    }

    private var budgetViewController: BudgetController? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: BudgetController.self)) as? BudgetController
    }

    private var chatsViewController: ChatsController? {
        return chatsSB.instantiateViewController(withIdentifier: String(describing: ChatsController.self)) as? ChatsController
    }

    private var tasksViewController: TasksController? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: TasksController.self)) as? TasksController
    }

    private var addTaskController: AddTask? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: AddTask.self)) as? AddTask
    }

    func start() {
        guard let vc = mainViewController else {return}
        

        let viewModel = MainModel()

        viewModel.budgetPressed = { [weak self] in
            self?.navigateToBudget()
        }

        viewModel.chatPressed = { [weak self] in
            self?.navigateToChats()
        }

        viewModel.ideasPressed = { [weak self] in
            self?.navigateToIdeas()
        }

        viewModel.tasksPressed = { [weak self] in
            self?.navigateToTasks()
        }

        viewModel.backPressed = { [weak self] in
            self?.tabbar?.dismiss(animated: true, completion: nil)
            self?.backPressed?()
        }
        viewModel.spaceName = self.spaceName

        vc.viewModel = viewModel

        rootController = UINavigationController(rootViewController: vc)
        guard let navController = rootController else { return }
        tabbar?.present(navController, animated: true, completion: nil)
    }

    private func navigateToBudget() {
        guard let vc = budgetViewController else { return }
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChats() {
        guard let vc = chatsViewController else { return }
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToIdeas() {
        guard let vc = ideasViewController else { return }
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTasks() {
        guard let vc = tasksViewController else { return }
        let viewModel = TasksModel()
        
        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTask()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        rootController?.pushViewController(vc, animated: true)
    }
}

