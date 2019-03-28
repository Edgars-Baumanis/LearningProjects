//
//  InProgressDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class InProgressDetailsModel {
    
    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private let taskService: PTaskService?

    var task: TaskDO?
    var leaveDetails: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, task: TaskDO?, taskService: PTaskService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.taskService = taskService
        self.task = task
    }

    func taskDone() {
        taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "Done", caller: "InProgress", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.leaveDetails?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func deletePressed() {
        taskService?.deleteTask(spaceKey: spaceKey, topicKey: taskTopic?.key, taskKey: task?.key, caller: "InProgress", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.leaveDetails?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
