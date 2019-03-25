//
//  TasksModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class TasksModel {
    var addTaskPressed: (() -> Void)?
    var dataSource: [TaskTopic] = []
    var filteredDataSource: [TaskTopic]?
    var dataSourceChanged: (() -> Void)?
    var cellPressed: ((_ taskTopic: TaskTopic) -> Void)?
    private var ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private var spaceKey: String?

    init(spaceKey: String?) {
        self.spaceKey = spaceKey
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
        filteredDataSource = []
    }

    func getTaskTopics() {
        databaseHandle = ref?.child("Spaces").child(spaceKey!).child("Tasks").observe(.childAdded, with:  { (snapshot) in
            let post = snapshot.value as? [String: AnyObject]
            guard
                let taskName = post?["name"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newTopic = TaskTopic(name: taskName, key: key)
            self.dataSource.append(newTopic)
            self.filteredDataSource?.append(newTopic)
            self.dataSourceChanged?()
        })
    }
}
