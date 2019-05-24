//
//  TasksModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksModel {

    private let spaceKey: String?
    private let taskService: PTaskService?
    
    var addTaskPressed: (() -> Void)?
    var dataSource: [TopicDO] = []
    var filteredDataSource: [TopicDO] = []
    var dataSourceChanged: (() -> Void)?
    var cellPressed: ((_ taskTopic: TopicDO) -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, taskService: PTaskService?) {
        self.spaceKey = spaceKey
        self.taskService = taskService
    }

    func getTaskTopics() {
        taskService?.getTopics(
            spaceKey: spaceKey,
            completionHandler: { [weak self] (topic, error) in
            if error == nil {
                guard let newTopic = topic else { return }
                self?.dataSource.append(newTopic)
                self?.filteredDataSource.append(newTopic)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
