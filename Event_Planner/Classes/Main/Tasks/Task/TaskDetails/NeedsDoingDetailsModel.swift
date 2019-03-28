//
//  NeedsDoingDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class NeedsDoingDetailsModel {

    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private let taskService: PTaskService?
    
    var task: TaskDO?
    var leaveDetails: (() -> Void)?
    var calculateBoxHeight: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, task: TaskDO?, taskService: PTaskService?) {
        self.taskService = taskService
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
    }

    func inProgressPressed() {
        taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "InProgress", caller: "NeedsDoing", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.leaveDetails?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func deletePressed() {
        taskService?.deleteTask(spaceKey: spaceKey, topicKey: taskTopic?.key, taskKey: task?.key, caller: "NeedsDoing", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.leaveDetails?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}

