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
    var addPressed: (() -> Void)?
    var dataSource: [Task] = []
    var dataSourceChanged: (() -> Void)?
    private var spaceName: String?
    private var taskTopic: TaskTopic?
    private var ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?

    init(spaceName: String?, taskTopic: TaskTopic?) {
        self.taskTopic = taskTopic
        self.spaceName = spaceName
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
    }

    func getData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let description = post?["description"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newTask = Task(name: name, description: description, key: key)
            self.dataSource.append(newTask)
            self.dataSourceChanged?()

        })
    }
}
