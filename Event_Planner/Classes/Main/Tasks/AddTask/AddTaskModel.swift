//
//  AddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

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
