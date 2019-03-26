//
//  TaskNeedsDoingModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class TaskNeedsDoingModel {

    private var spaceKey: String?
    private var taskTopic: TaskTopic?
    private var ref: DatabaseReference?
    
    var navigateToAddTask: (() -> Void)?
    var dataSource: [Task] = []
    var dataSourceChanged: (() -> Void)?
    var navigateToDetails: ((_ task: Task?) -> Void)?

    init(spaceKey: String?, taskTopic: TaskTopic?) {
        self.taskTopic = taskTopic
        self.spaceKey = spaceKey
        ref = Database.database().reference()
    }

    func getData() {
         ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let description = post?["description"] as? String,
                let key = snapshot.key as? String,
                let ownerID = post?["ownerID"] as? String,
                let deadline = post?["deadline"] as? String
                else { return }
            let newTask = Task(name: name, description: description, key: key, ownerID: ownerID, deadline: deadline)
            self.dataSource.append(newTask)
            self.dataSourceChanged?()

        })
    }

    func dataDeleted() {
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").observe(.childRemoved, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let description = post?["description"] as? String,
                let key = snapshot.key as? String,
                let ownerID = post?["ownerID"] as? String,
                let deadline = post?["deadline"] as? String
                else { return }
            let removedTask = Task(name: name, description: description, key: key, ownerID: ownerID, deadline: deadline)
            self.dataSource.enumerated().forEach { (idx, task) in
                if
                    task.name == removedTask.name &&
                    task.description == removedTask.description &&
                        task.key == removedTask.key {
                    self.dataSource.remove(at: idx)
                }
            }
            self.dataSourceChanged?()
        })
    }
}
