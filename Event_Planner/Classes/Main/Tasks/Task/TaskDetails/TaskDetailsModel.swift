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
    var section: String?

    var task: TaskDO?
    var dateFormatter: DateFormatter?
    var succesfulTransfer: (() -> Void)?
    var deletePressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskTopic: TopicDO?, task: TaskDO?, taskService: PTaskService?, section: String?) {
        self.taskService = taskService
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
        self.section = section
        
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "EEEE, MMM d, yyyy, HH:mm"
    }

    func progressTask() {
        switch section {
        case "NeedsDoing":
            taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "InProgress", caller: section, completionHandler: { [weak self] (error) in
                if error == nil {
                    self?.section = "InProgress"
                    self?.succesfulTransfer?()
                } else {
                    self?.errorMessage?(error)
                }
            })
        case "InProgress":
            taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "Done", caller: section, completionHandler: { [weak self] (error) in
                if error == nil {
                    self?.section = "Done"
                    self?.succesfulTransfer?()
                } else {
                    self?.errorMessage?(error)
                }
            })
        case "Done":
            taskService?.transferTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, transferTo: "NeedsDoing", caller: section, completionHandler: { [weak self] (error) in
                if error == nil {
                    self?.section = "NeedsDoing"
                    self?.succesfulTransfer?()
                } else {
                    self?.errorMessage?(error)
                }
            })
        default:
            return
        }

    }

    func deleteTask() {
        taskService?.deleteTask(spaceKey: spaceKey, topicKey: taskTopic?.key, taskKey: task?.key, caller: section, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.deletePressed?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func saveData(taskName: String?, taskDescription: String?, deadline: String?) {
        guard
            let taskName = taskName,
            let taskDescription = taskDescription,
            let deadline = deadline,
            !taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !taskDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !deadline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            else {
                errorMessage?("Please enter task name and/or task description and/or task deadline")
                return
        }
        let task = TaskDO(
            name: taskName.trimmingCharacters(in: .whitespacesAndNewlines),
            description: taskDescription.trimmingCharacters(in: .whitespacesAndNewlines),
            key: self.task?.key,
            ownerID: (self.task?.ownerID)!,
            deadline: deadline.trimmingCharacters(in: .whitespacesAndNewlines))
        
        taskService?.saveTask(spaceKey: spaceKey, topicKey: taskTopic?.key, task: task, caller: section, taskKey: task.key, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.deletePressed?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
