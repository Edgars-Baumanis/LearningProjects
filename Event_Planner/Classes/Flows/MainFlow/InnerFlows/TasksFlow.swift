//
//  TasksFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//
/********************************
AppFlow task branch file
 This file controls the flow of the application for the task branch

 contains functions:
    *   start() - inhereted function, that is used as a start function for this class
    *   navigateToTasks() - contains navigation to task topic screen
    *   navigateToAddTaskTopic() - contains navigation to add task topic screen
    *   navigateToTaskOverview() - contains navigation to task overview screen
    *   navigateToAddTask() - contains navigation to add task screen
    *   navigateToTaskDetails() - contains navigation to task details screen

********************************/
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

//  initialising all the necessary variables
    init(spaceKey: String?, rootController: UINavigationController?, userService: PUserService?, taskService: PTaskService?) {
        self.userService = userService
        self.spaceKey = spaceKey
        self.rootController = rootController
        self.taskService = taskService
    }

// Declaring all the necessary UIStoryboards for declaring UIViewControllers
    private lazy var tasksSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TasksSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var taskTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.TaskTopicSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var addTaskSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.AddTaskSB.rawValue, bundle: Bundle.main)
    }()

//  Declaring all the necessary UIViewControllers for navigation
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

//      called when user has pressed button
        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTaskTopic()
        }
//      called when user has pressed a cell
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

//      called when user has added topic to DB
        viewModel.navigateToTaskTopic = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTaskOverview() {
        guard let vc = taskOverviewController else { return }
        let viewModel = TaskOverviewModel(spaceKey: spaceKey, taskTopic: taskTopic, taskService: taskService)

//      called when user has pressed on a cell
        viewModel.navigateToDetails = { [weak self] task, section in
            self?.rootController?.navigationBar.prefersLargeTitles = false
            self?.task = task
            self?.section = section
            self?.navigateToTaskDetails()
        }
//      called when user has pressed on add task button
        viewModel.navigateToAddTask = { [weak self] in
            self?.navigateToAddTask()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        let viewModel = AddTaskModel(spaceKey: spaceKey, taskTopic: taskTopic, userServices: userService, taskService: taskService)
//      called when user has added task to DB
        viewModel.addTaskPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToTaskDetails() {
        guard let vc = taskDetails else { return }
        let viewModel = TaskDetailsModel(spaceKey: spaceKey, taskTopic: taskTopic, task: task, taskService: taskService, section: section)
//      called when user has deleted task from DB
        viewModel.deletePressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
