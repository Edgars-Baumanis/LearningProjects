//
//  TasksFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksFlow: FlowController {
    private var rootController: UINavigationController?
    private var spaceName: String?
    private var taskTopic: TaskTopic?
    private var taskTabbar: UITabBarController?
    
    init(spaceName: String?, rootController: UINavigationController?) {
        self.spaceName = spaceName
        self.rootController = rootController
    }

    private lazy var tasksSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TasksSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var taskTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TaskTopicSB.rawValue, bundle: Bundle.main)
    }()

    private var tasksViewController: TasksController? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: TasksController.self)) as? TasksController
    }

    private var addTaskTopicController: AddTask? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: AddTask.self)) as? AddTask
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

    private var addTaskController: TaskAddTask? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskAddTask.self)) as? TaskAddTask
    }

    func start() {
        navigateToTasks()
    }

    private func navigateToTasks() {
        guard let vc = tasksViewController else { return }
        let viewModel = TasksModel(spaceName: spaceName)

        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTaskTopic()
        }

        viewModel.cellPressed = { [weak self] taskTopic in
            self?.taskTopic = TaskTopic(name: taskTopic.name, key: taskTopic.key)
            self?.navigateToTaskTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTaskTopic() {
        guard let vc = addTaskTopicController else { return }
        let viewModel = AddTaskModel(spaceName: spaceName)
        viewModel.addTaskPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
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
        vcNeedsDoing.tabBarItem = UITabBarItem(title: "Needs Doing", image: UIImage(named: "task-needsDoing"), tag: 0)
        let needsDoingViewModel = TaskNeedsDoingModel(spaceName: spaceName, taskTopic: taskTopic)
        needsDoingViewModel.addPressed = { [weak self] in
            self?.navigateToAddTask()
        }
        vcNeedsDoing.viewModel = needsDoingViewModel

        vcInProgress.tabBarItem = UITabBarItem(title: "In Progress", image: UIImage(named: "task-inProgress"), tag: 1)
        vcDone.tabBarItem = UITabBarItem(title: "Done", image: UIImage(named: "task-done"), tag: 2)
        guard let newTaskTabbar = taskTabbar else { return }

        newTaskTabbar.viewControllers = [vcNeedsDoing, vcInProgress, vcDone]
        rootController?.pushViewController(newTaskTabbar, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        let viewModel = TaskAddTaskModel(spaceName: spaceName, taskTopic: taskTopic)
        viewModel.addTaskPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
