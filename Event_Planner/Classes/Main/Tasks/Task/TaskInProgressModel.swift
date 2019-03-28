//
//  TaskInProgressModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskInProgressModel {

    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private var taskService: PTaskService?

    var dataSource: [TaskDO] = []
    var dataSourceChanged: (() -> Void)?
    var navigateToDetails: ((_ task: TaskDO?) -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, taskService: PTaskService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.taskService = taskService
    }

    func getData() {
        taskService?.getTasks(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "InProgress", completionHandler: { [weak self] (task, error) in
            if error == nil {
                guard let newTask = task else { return }
                self?.dataSource.append(newTask)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func dataDeleted() {
        taskService?.taskDeleted(spaceKey: spaceKey, topicKey: taskTopic?.key, caller: "InProgress", completionHandler: { [weak self] (removedTask, error) in
            if error == nil {
                guard let removedTask = removedTask else { return }
                self?.dataSource.enumerated().forEach { (idx, task) in
                    if
                        task.name == removedTask.name &&
                            task.description == removedTask.description &&
                            task.key == removedTask.key {
                        self?.dataSource.remove(at: idx)
                    }
                }
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func cellPressed(index: Int) {
        navigateToDetails?(dataSource[index])
    }
}
