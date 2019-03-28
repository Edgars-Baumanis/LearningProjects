//
//  DoneDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class DoneDetailsModel {

    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private let taskService: PTaskService?

    var task: TaskDO?
    var leaveDetails: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(task: TaskDO?, spaceKey: String?, taskTopic: TopicDO?, taskService: PTaskService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
        self.taskService = taskService
    }

    func deleteTask() {
        taskService?.deleteTask(spaceKey: spaceKey, topicKey: taskTopic?.key, taskKey: task?.key, caller: "Done", completionHandler: { [weak self] (error) in
            if error == nil {
                self?.leaveDetails?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

}
