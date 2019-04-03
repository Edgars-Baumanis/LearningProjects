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
    private var userService: PUserService?
    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private var taskTabbar: UITabBarController?
    private var task: TaskDO?
    private var taskService: PTaskService?
    private var section: String?
    
    init(spaceKey: String?, rootController: UINavigationController?, userService: PUserService?, taskService: PTaskService?) {
        self.userService = userService
        self.spaceKey = spaceKey
        self.rootController = rootController
        self.taskService = taskService
    }

    private lazy var tasksSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TasksSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var taskTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TaskTopicSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var addTaskSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.AddTaskSB.rawValue, bundle: Bundle.main)
    }()

    private var tasksViewController: TasksController? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: TasksController.self)) as? TasksController
    }

    private var addTaskTopicController: AddTaskTopic? {
        return tasksSB.instantiateViewController(withIdentifier: String(describing: AddTaskTopic.self)) as? AddTaskTopic
    }

    private var addTaskController: AddTask? {
        return addTaskSB.instantiateViewController(withIdentifier: String(describing: AddTask.self)) as? AddTask
    }

    private var taskOverviewController: TaskOverview? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskOverview.self)) as? TaskOverview
    }

    private var taskDetails: TaskDetails? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskDetails.self)) as? TaskDetails
    }

    func start() {
        navigateToTasks()
    }

    private func navigateToTasks() {
        guard let vc = tasksViewController else { return }
        let viewModel = TasksModel(spaceKey: spaceKey, taskService: taskService)

        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTaskTopic()
        }

        viewModel.cellPressed = { [weak self] taskTopic in
            self?.taskTopic = TopicDO(name: taskTopic.name, key: taskTopic.key)
            self?.navigateToTaskOverview()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTaskTopic() {
        guard let vc = addTaskTopicController else { return }
        let viewModel = AddTaskTopicModel(spaceKey: spaceKey, taskService: taskService)
        viewModel.navigateToTaskTopic = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTaskOverview() {
        guard let vc = taskOverviewController else { return }
        let viewModel = TaskOverviewModel(spaceKey: spaceKey, taskTopic: taskTopic, taskService: taskService)
        viewModel.navigateToDetails = { [weak self] task, section in
            self?.task = task
            self?.section = section
            self?.navigateToTaskDetails()
        }
        viewModel.navigateToAddTask = { [weak self] in
            self?.navigateToAddTask()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        let viewModel = AddTaskModel(spaceKey: spaceKey, taskTopic: taskTopic, userServices: userService, taskService: taskService)
        viewModel.addTaskPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTaskDetails() {
        guard let vc = taskDetails else { return }
        let viewModel = TaskDetailsModel(spaceKey: spaceKey, taskTopic: taskTopic, task: task, taskService: taskService, section: section)
        viewModel.deletePressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
