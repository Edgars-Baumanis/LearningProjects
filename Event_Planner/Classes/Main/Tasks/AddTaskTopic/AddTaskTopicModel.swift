//
//  AddTaskTopicModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTaskTopicModel {

    private var spaceKey: String?
    private let taskService: PTaskService?
    
    var navigateToTaskTopic: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskService: PTaskService?) {
        self.taskService = taskService
        self.spaceKey = spaceKey
    }
    
    func addTask(taskName: String?) {
        taskService?.addTopic(
            topicName: taskName?.trimmingCharacters(in: .whitespacesAndNewlines),
            spaceKey: spaceKey,
            completionHandler: { [weak self] (error) in
            if error == nil {
                self?.navigateToTaskTopic?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
