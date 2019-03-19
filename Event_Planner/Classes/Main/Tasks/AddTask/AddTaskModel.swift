//
//  AddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

struct TaskTopic {
    let name: String
    let description: String

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    func sendData() -> Any {
        return [
            "name": name,
            "description": description
        ]
    }
}

class AddTaskModel {
    var emptyFields: (()->Void)?
    private var ref: DatabaseReference?
    private var spaceName: String?

    init(spaceName: String?) {
        ref = Database.database().reference()
        self.spaceName = spaceName
    }

    func addTask(taskName: String?, taskDescription: String?) {
        guard taskName?.isEmpty != true, taskDescription?.isEmpty != true else {
            emptyFields?()
            return
        }
        let newTask = TaskTopic(name: taskName!, description: taskDescription!)
        ref?.child("Spaces").child(spaceName!).child("Tasks").child(taskName!).setValue(newTask.sendData())
    }
}
