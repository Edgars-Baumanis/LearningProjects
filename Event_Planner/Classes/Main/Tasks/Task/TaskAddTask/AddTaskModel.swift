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
            let taskName = taskName,
            let taskDescription = taskDescription,
            let deadline = deadline,
            !taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !taskDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !deadline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let user = userServices?.user?.userName
            else {
                errorMessage?("Please enter task name and/or task description and/or task deadline")
                return
        }
        let newTask = TaskDO(
            name: taskName.trimmingCharacters(in: .whitespacesAndNewlines),
            description: taskDescription.trimmingCharacters(in: .whitespacesAndNewlines),
            key: nil,
            ownerID: user,
            deadline: deadline.trimmingCharacters(in: .whitespacesAndNewlines))
        taskService?.addTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: newTask) { [weak self] (error) in
            if error == nil {
                self?.addTaskPressed?()
            } else {
                self?.errorMessage?(error)
            }
        }
    }
}
