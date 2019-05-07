//
//  TaskAddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTaskModel {

    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private var userServices: PUserService?
    private let taskService: PTaskService?

    var errorMessage: ((String?) -> Void)?
    var addTaskPressed: (() -> Void)?
    var dateFormatter: DateFormatter?

    init(spaceKey: String?, taskTopic: TopicDO?, userServices: PUserService?, taskService: PTaskService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.userServices = userServices
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "EEEE, MMM d, yyyy, HH:mm"
        self.taskService = taskService
    }

    func addTask(taskName: String?, taskDescription: String?, deadline: String?) {
        guard
            taskName?.isEmpty != true,
            taskDescription?.isEmpty != true,
            deadline?.isEmpty != true,
            let user = userServices?.user?.userName
            else {
                errorMessage?("Empty Fields")
                return
        }
        let newTask = TaskDO(name: taskName!, description: taskDescription!, key: nil, ownerID: user, deadline: deadline!)
        taskService?.addTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: newTask) { [weak self] (error) in
            if error == nil {
                self?.addTaskPressed?()
            } else {
                self?.errorMessage?(error)
            }
        }
    }
}
