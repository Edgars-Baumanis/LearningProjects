//
//  TaskOverviewModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class TaskOverviewModel {
    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private let taskService: PTaskService?

    var navigateToAddTask: (() -> Void)?
    var dataSource: [[TaskDO]] = [[], [], []]
    var dataSourceChanged: (() -> Void)?
    var navigateToDetails: ((_ task: TaskDO?) -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, taskService: PTaskService?) {
        self.taskTopic = taskTopic
        self.spaceKey = spaceKey
        self.taskService = taskService
        getNeedsDoingData()
        dataProgressDeleted()
        dataNeedsDoingDeleted()
        dataDoneDeleted()
    }

    func getNeedsDoingData() {
        taskService?.getTasks(spaceKey: spaceKey, topicKey: taskTopic?.key, completionHandler: { [weak self] (tasks, error) in
            if error == nil {
                guard let newTasks = tasks else { return }
                self?.dataSource = newTasks
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func dataNeedsDoingDeleted() {
        taskService?.taskDeleted(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "NeedsDoing", completionHandler: { [weak self] (removedTask, error) in
            if error == nil {
                guard let removedTask = removedTask else { return }
                self?.dataSource[0].enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource[0].remove(at: idx)
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
                self?.dataSource[1].enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource[1].remove(at: idx)
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
                self?.dataSource[2].enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource[2].remove(at: idx)
                    }
                }
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func cellPressed(section: Int, index: Int) {
        navigateToDetails?(dataSource[section][index])
    }
}

