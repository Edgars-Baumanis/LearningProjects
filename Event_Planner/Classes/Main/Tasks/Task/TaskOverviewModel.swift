//
//  TaskOverviewModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class TaskOverviewModel {
    private let spaceKey: String?
    let taskTopic: TopicDO?
    private let taskService: PTaskService?

    var navigateToAddTask: (() -> Void)?
    var dataSource: [PresentableTaskDO] = [
            PresentableTaskDO(tasks: [], isExpanded: true),
            PresentableTaskDO(tasks: [], isExpanded: true),
            PresentableTaskDO(tasks: [], isExpanded: true)
    ]
    var dataSourceChanged: (() -> Void)?
    var navigateToDetails: ((_ task: TaskDO?, String?) -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, taskService: PTaskService?) {
        self.taskTopic = taskTopic
        self.spaceKey = spaceKey
        self.taskService = taskService
        getNeedsDoingData()
        reloadData()
        dataProgressDeleted()
        dataNeedsDoingDeleted()
        dataDoneDeleted()
    }

    private func getNeedsDoingData() {
        taskService?.getTasks(spaceKey: spaceKey, topicKey: taskTopic?.key, completionHandler: { [weak self] (tasks, section, error) in
            if error == nil {
                guard let newTasks = tasks, let section = section else { return }

                self?.dataSource[section].tasks.append(newTasks)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    private func reloadData() {
        taskService?.reloadTasks(spaceKey: spaceKey, topicKey: taskTopic?.key, completionHandler: { [weak self] (task, section, error) in
            if error == nil {
                guard let newTask = task, let section = section else { return }
                if self?.dataSource[section].tasks.contains(where: { (task) -> Bool in
                    task.key == newTask.key
                }) == true {
                    return
                } else {
                    self?.dataSource[section].tasks.append(newTask)
                    self?.dataSourceChanged?()
                }
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func dataNeedsDoingDeleted() {
        taskService?.taskDeleted(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "NeedsDoing", completionHandler: { [weak self] (removedTask, error) in
            if error == nil {
                guard let removedTask = removedTask else { return }
                self?.dataSource[0].tasks.enumerated().forEach { (idx, task) in
                    if task.name == removedTask.name &&
                        task.description == removedTask.description &&
                        task.key == removedTask.key {
                        self?.dataSource[0].tasks.remove(at: idx)
                    }
                }
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func dataProgressDeleted() {
        taskService?.taskDeleted(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "InProgress", completionHandler: { [weak self] (removedTask, error) in
            if error == nil {
                guard let removedTask = removedTask else { return }
                self?.dataSource[1].tasks.enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource[1].tasks.remove(at: idx)
                    }
                }
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
    
    func dataDoneDeleted() {
        taskService?.taskDeleted(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "Done", completionHandler: { [weak self] (removedTask, error) in
            if error == nil {
                guard let removedTask = removedTask else { return }
                self?.dataSource[2].tasks.enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource[2].tasks.remove(at: idx)
                    }
                }
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func cellPressed(section: Int, index: Int) {
        switch section {
        case 0:
            navigateToDetails?(dataSource[section].tasks[index], "NeedsDoing")
        case 1:
            navigateToDetails?(dataSource[section].tasks[index], "InProgress")
        case 2:
            navigateToDetails?(dataSource[section].tasks[index], "Done")
        default:
            return
        }

    }
}

