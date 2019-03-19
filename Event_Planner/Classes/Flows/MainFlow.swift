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
    private var taskTabbar: UITabBarController?
    private var spaceName: String?
    private var chatName: String?
    private var ideaTopicName: String?
    private var userServices: PUserService?
    private var budgetFieldName: String?
    private var budgetFieldSum: String?
    private var fieldKey: String?
    
    init(with tabbar: UITabBarController, with spaceName: String?, with userServices: PUserService?) {
        self.rootTabbar = tabbar
        self.spaceName = spaceName
        self.userServices = userServices
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

    private lazy var chatSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.ChatSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var ideaTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.IdeaTopicSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var taskTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TaskTopicSB.rawValue, bundle: Bundle.main)
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

    private var addChatController: CreateChat? {
        return chatsSB.instantiateViewController(withIdentifier: String(describing: CreateChat.self)) as? CreateChat
    }

    private var addIdeasController: AddTopicController? {
        return ideasSB.instantiateViewController(withIdentifier: String(describing: AddTopicController.self)) as? AddTopicController
    }

    private var configureBudget: ConfigureBudget? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: ConfigureBudget.self)) as? ConfigureBudget
    }

    private var chatController: ChatController? {
        return chatSB.instantiateViewController(withIdentifier: String(describing: ChatController.self)) as? ChatController
    }

    private var ideaTopic: IdeaTopic? {
        return ideaTopicSB.instantiateViewController(withIdentifier: String(describing: IdeaTopic.self)) as? IdeaTopic
    }

    private var taskNeedsDoingController: TaskNeedsDoing? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskNeedsDoing.self)) as? TaskNeedsDoing
    }

    private var taskInProgressController: TaskInProgress? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskInProgress.self)) as? TaskInProgress
    }

    private var taskDoneController: TaskDone? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskDone.self)) as? TaskDone
    }

    private var addBudgetFieldController: AddBudgetField? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: AddBudgetField.self)) as? AddBudgetField
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
            self?.rootTabbar?.dismiss(animated: true, completion: nil)
            self?.backPressed?()
        }
        viewModel.spaceName = self.spaceName

        vc.viewModel = viewModel

        rootController = UINavigationController(rootViewController: vc)
        guard let navController = rootController else { return }
        rootTabbar?.present(navController, animated: true, completion: nil)
    }

    private func navigateToBudget() {
        guard let vc = budgetViewController else { return }
        let viewModel = BudgetModel(spaceName: spaceName)
        viewModel.configurePressed = { [weak self] fieldName, fieldSum, fieldKey in
            self?.fieldKey = fieldKey
            self?.budgetFieldName = fieldName
            self?.budgetFieldSum = fieldSum
            self?.navigateToConfigureBudget()
        }
        viewModel.addPressed = { [weak self] in
            self?.navigateToAddBudgetField()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChats() {
        guard let vc = chatsViewController else { return }
        let viewModel = ChatsModel(spaceName: spaceName)
        viewModel.addChatPressed = { [weak self] in
            self?.navigateToAddChat()
        }
        viewModel.cellClicked = { [weak self] cellName in
            self?.chatName = cellName
            self?.navigateToChat()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToIdeas() {
        guard let vc = ideasViewController else { return }
        let viewModel = IdeasModel(spaceName: spaceName)

        viewModel.addTopicPressed = { [weak self] in
            self?.navigateToAddTopic()
        }

        viewModel.cellPressed = { [weak self] cellName in
            self?.ideaTopicName = cellName
            self?.navigateToIdeaTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTasks() {
        guard let vc = tasksViewController else { return }
        let viewModel = TasksModel(spaceName: spaceName)
        
        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTask()
        }

        viewModel.cellPressed = { [weak self] in
            self?.navigateToTaskTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        let viewModel = AddTaskModel(spaceName: spaceName)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddChat() {
        guard let vc = addChatController else { return }
        let viewModel = CreateChatModel(spaceName: spaceName)
        viewModel.chatCreated = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTopic() {
        guard let vc = addIdeasController else { return }
        let viewModel = AddTopicModel(spaceName: spaceName)
        viewModel.addTopicPressed = { [weak self] in
            self?.navigateToIdeas()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToConfigureBudget() {
        guard let vc = configureBudget else { return }
        let viewModel = ConfigureModel(fieldName: budgetFieldName, fieldSum: budgetFieldSum, spaceName: spaceName, fieldKey: fieldKey)

        viewModel.savePressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChat() {
        guard let vc = chatController else { return }
        let viewModel = ChatModel(chatName: chatName, userServices: userServices, spaceName: spaceName)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToIdeaTopics() {
        guard let vc = ideaTopic else { return }
        let viewModel = IdeaTopicModel(topicName: ideaTopicName)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTaskTopics() {
        taskTabbar = UITabBarController()
        guard
            let vcNeedsDoing = taskNeedsDoingController,
            let vcInProgress = taskInProgressController,
            let vcDone = taskDoneController
            else { return }
        vcNeedsDoing.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        vcInProgress.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        vcDone.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        guard let newTaskTabbar = taskTabbar else { return }
        rootController?.pushViewController(newTaskTabbar, animated: true)
        newTaskTabbar.viewControllers = [vcNeedsDoing, vcInProgress, vcDone]
    }

    private func navigateToAddBudgetField() {
        guard let vc = addBudgetFieldController else { return }
        let viewModel = AddBudgetModel(spaceName: spaceName)
        viewModel.fieldAdded = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}

