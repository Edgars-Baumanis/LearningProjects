//
//  TaskDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class TaskDetailsModel {
    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private let taskService: PTaskService?

    var task: TaskDO?
    var deletePressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, task: TaskDO?, taskService: PTaskService?) {
        self.taskService = taskService
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
    }

    func progressTask() {
        taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "InProgress", caller: "NeedsDoing", completionHandler: { [weak self] (error) in
            if error == nil {
                // swap buttons
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func deleteTask() {
        taskService?.deleteTask(spaceKey: spaceKey, topicKey: taskTopic?.key, taskKey: task?.key, caller: "NeedsDoing", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.deletePressed?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
