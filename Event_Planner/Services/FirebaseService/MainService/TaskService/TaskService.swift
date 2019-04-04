//
//  TaskService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import Firebase

class TaskService: PTaskService {

    private let ref = Database.database().reference()
    private let spacesString = "Spaces"
    private let taskString = "Tasks"

    func getTopics(spaceKey: String?, completionHandler: @escaping (TopicDO?, String?) -> Void) {
        guard spaceKey?.isEmpty != true else {
            completionHandler(nil, "Empty fields for database reference")
            return
        }
        ref.child(spacesString).child(spaceKey!).child(taskString).observe(.childAdded, with:  { (snapshot) in
            let post = snapshot.value as? [String: AnyObject]
            guard
                let taskName = post?["name"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newTopic = TopicDO(name: taskName, key: key)
            completionHandler(newTopic, nil)
        })
    }

    func addTopic(topicName: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void) {
        guard topicName?.isEmpty != true, spaceKey?.isEmpty != true else {
            completionHandler("Please enter Space name and/or Space password and/or Space description")
            return
        }
        let newTopic = TopicDO(name: topicName!, key: nil)
        ref.child(spacesString).child(spaceKey!).child(taskString).childByAutoId().setValue(newTopic.sendData())
        completionHandler(nil)
    }

    func getTasks(spaceKey: String?, topicKey: String?, completionHandler: @escaping (TaskDO?, Int?, String?) -> Void) {
        guard spaceKey?.isEmpty != true, topicKey?.isEmpty != true else {
            completionHandler(nil, nil, "Empty fields for database reference")
            return
        }
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]
            post?.forEach({ (key, value) in
                let newValue = value as? [String : Any]
                guard
                    let name = newValue?["name"] as? String,
                    let description = newValue?["description"] as? String,
                    let key = key as? String,
                    let ownerID = newValue?["ownerID"] as? String,
                    let deadline = newValue?["deadline"] as? String
                    else { return }
                let task = TaskDO(name: name, description: description, key: key, ownerID: ownerID, deadline: deadline)
                switch snapshot.key as? String {
                case "Done":
                    completionHandler(task, 2, nil)
                case "InProgress":
                    completionHandler(task, 1, nil)
                case "NeedsDoing":
                    completionHandler(task, 0 , nil)
                default:
                    completionHandler(nil, nil, "borked")
                }
            })

        })
    }

    func reloadTasks(spaceKey: String?, topicKey: String?, completionHandler: @escaping (TaskDO?, Int?, String?) -> Void) {
        guard spaceKey?.isEmpty != true, topicKey?.isEmpty != true else {
            completionHandler(nil, nil, "Empty fields for database reference")
            return
        }
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]
            post?.forEach({ (key, value) in
                let newValue = value as? [String : Any]
                guard
                    let name = newValue?["name"] as? String,
                    let description = newValue?["description"] as? String,
                    let key = key as? String,
                    let ownerID = newValue?["ownerID"] as? String,
                    let deadline = newValue?["deadline"] as? String
                    else { return }
                let task = TaskDO(name: name, description: description, key: key, ownerID: ownerID, deadline: deadline)
                switch snapshot.key as? String {
                case "Done":
                    completionHandler(task, 2, nil)
                case "InProgress":
                    completionHandler(task, 1, nil)
                case "NeedsDoing":
                    completionHandler(task, 0 , nil)
                default:
                    completionHandler(nil, nil, "borked")
                }
            })
        })
    }


    func taskDeleted(spaceKey: String?, topicKey: String?, caller: String, completionHandler: @escaping (TaskDO?, String?) -> Void) {
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).child(caller).observe(.childRemoved, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let description = post?["description"] as? String,
                let key = snapshot.key as? String,
                let ownerID = post?["ownerID"] as? String,
                let deadline = post?["deadline"] as? String
                else { return }
            let removedTask = TaskDO(name: name, description: description, key: key, ownerID: ownerID, deadline: deadline)
            completionHandler(removedTask, nil)
        })
    }

    func addTask(spaceKey: String?, topicKey: String?, task: TaskDO?, completionHandler: @escaping (String?) -> Void) {
        guard spaceKey?.isEmpty != true, topicKey?.isEmpty != true, let newTask = task else {
            completionHandler("Empty fields for database reference")
            return
        }
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).child("NeedsDoing").childByAutoId().setValue(newTask.sendData())
        completionHandler(nil)
    }

    func deleteTask(spaceKey: String?, topicKey: String?, taskKey: String?, caller: String?, completionHandler: @escaping (String?) -> Void) {
        guard
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true,
            taskKey?.isEmpty != true,
            let caller = caller
            else {
                completionHandler("Empty fields for database reference")
                return
        }
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).child(caller).child(taskKey!).removeValue()
        completionHandler(nil)
    }

    func transferTask(spaceKey: String?, topicKey: String?, task: TaskDO?, transferTo: String?, caller: String?, completionHandler: @escaping (String?) -> Void) {
        guard
            let newTask = task, spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true,
            let taskKey = task?.key,
            let caller = caller,
            let transferTo = transferTo
            else {
                completionHandler("Empty fields for database reference")
                return
        }
        let task = TaskDO(name: newTask.name, description: newTask.description, key: nil, ownerID: newTask.ownerID, deadline: newTask.deadline)
        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).child(transferTo).child(taskKey).setValue(task.sendData())

        ref.child(spacesString).child(spaceKey!).child(taskString).child(topicKey!).child(caller).child(taskKey).removeValue()
        completionHandler(nil)
    }
}
