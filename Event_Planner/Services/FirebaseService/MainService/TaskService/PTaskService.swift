//
//  PTaskService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PTaskService {
    func getTopics(spaceKey: String?, completionHandler: @escaping (TopicDO?, String?) -> Void)

    func addTopic(topicName: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void)

    func getTasks(spaceKey: String?, topicKey: String?, completionHandler: @escaping (TaskDO?, Int?, String?) -> Void)

    func reloadTasks(spaceKey: String?, topicKey: String?, completionHandler: @escaping (TaskDO?, Int?, String?) -> Void)

    func taskDeleted(spaceKey: String?, topicKey: String?, caller: String, completionHandler: @escaping (TaskDO?, String?) -> Void)

    func addTask(spaceKey: String?, topicKey: String?, task: TaskDO?, completionHandler: @escaping (String?) -> Void)

    func deleteTask(spaceKey: String?, topicKey: String?, taskKey: String?, caller: String?, completionHandler: @escaping (String?) -> Void)

    func transferTask(spaceKey: String?, topicKey: String?, task: TaskDO?, transferTo: String?, caller: String?, completionHandler: @escaping (String?) -> Void)

}
