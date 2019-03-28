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
    private var needsDoingTask: TaskDO?
    private var inProgressTask: TaskDO?
    private var doneTask: TaskDO?
    
    init(spaceKey: String?, rootController: UINavigationController?, userService: PUserService?) {
        self.userService = userService
        self.spaceKey = spaceKey
        self.rootController = rootController
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

    private var taskNeedsDoingController: TaskNeedsDoing? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskNeedsDoing.self)) as? TaskNeedsDoing
    }

    private var taskInProgressController: TaskInProgress? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskInProgress.self)) as? TaskInProgress
    }

    private var taskDoneController: TaskDone? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: TaskDone.self)) as? TaskDone
    }

    private var addTaskController: AddTask? {
        return addTaskSB.instantiateViewController(withIdentifier: String(describing: AddTask.self)) as? AddTask
    }

    private var needsDoingDetails: NeedsDoingDetails? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: NeedsDoingDetails.self)) as? NeedsDoingDetails
    }

    private var inProgressDetails: InProgressDetails? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: InProgressDetails.self)) as? InProgressDetails
    }

    private var doneDetails: DoneDetails? {
        return taskTopicSB.instantiateViewController(withIdentifier: String(describing: DoneDetails.self)) as? DoneDetails
    }

    func start() {
        navigateToTasks()
    }

    private func navigateToTasks() {
        guard let vc = tasksViewController else { return }
        let viewModel = TasksModel(spaceKey: spaceKey)

        viewModel.addTaskPressed = { [weak self] in
            self?.navigateToAddTaskTopic()
        }

        viewModel.cellPressed = { [weak self] taskTopic in
            self?.taskTopic = TopicDO(name: taskTopic.name, key: taskTopic.key)
            self?.navigateToTaskTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTaskTopic() {
        guard let vc = addTaskTopicController else { return }
        let viewModel = AddTaskTopicModel(spaceKey: spaceKey)
        viewModel.navigateToTaskTopic = { [weak self] in
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
        let needsDoingViewModel = TaskNeedsDoingModel(spaceKey: spaceKey, taskTopic: taskTopic)
        needsDoingViewModel.navigateToAddTask = { [weak self] in
            self?.navigateToAddTask()
        }
        needsDoingViewModel.navigateToDetails = { [weak self] task in
            self?.needsDoingTask = task
            self?.navigateToNeedsDoingDetails()
        }
        vcNeedsDoing.viewModel = needsDoingViewModel

        vcInProgress.tabBarItem = UITabBarItem(title: "In Progress", image: UIImage(named: "task-inProgress"), tag: 1)
        let inProgressModel = TaskInProgressModel(spaceKey: spaceKey, taskTopic: taskTopic)
        inProgressModel.navigateToDetails = { [weak self] task in
            self?.inProgressTask = task
            self?.navigateToInProgressDetails()
        }
        vcInProgress.viewModel = inProgressModel

        vcDone.tabBarItem = UITabBarItem(title: "Done", image: UIImage(named: "task-done"), tag: 2)
        let doneModel = TaskDoneModel(spaceKey: spaceKey, taskTopic: taskTopic)
        doneModel.navigateToDetails = { [weak self] task in
            self?.doneTask = task
            self?.navigateToDoneDetails()
        }
        vcDone.viewModel = doneModel
        guard let newTaskTabbar = taskTabbar else { return }

        newTaskTabbar.viewControllers = [vcNeedsDoing, vcInProgress, vcDone]
        rootController?.pushViewController(newTaskTabbar, animated: true)
    }

    private func navigateToAddTask() {
        guard let vc = addTaskController else { return }
        let viewModel = AddTaskModel(spaceKey: spaceKey, taskTopic: taskTopic, userServices: userService)
        viewModel.addTaskPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToNeedsDoingDetails() {
        guard let vc = needsDoingDetails else { return }
        let viewModel = NeedsDoingDetailsModel(spaceKey: spaceKey, taskTopic: taskTopic, task: needsDoingTask)
        viewModel.leaveDetails = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToInProgressDetails() {
        guard let vc = inProgressDetails else { return }
        let viewModel = InProgressDetailsModel(spaceKey: spaceKey, taskTopic: taskTopic, task: inProgressTask)
        viewModel.leaveDetails = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToDoneDetails() {
        guard let vc = doneDetails else { return }
        let viewModel = DoneDetailsModel(task: doneTask, spaceKey: spaceKey, taskTopic: taskTopic)
        viewModel.leaveDetails = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
