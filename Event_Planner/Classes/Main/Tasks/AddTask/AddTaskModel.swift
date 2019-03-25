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
    var addTaskPressed: (() -> Void)?
    private var ref: DatabaseReference?
    private var spaceKey: String?

    init(spaceKey: String?) {
        ref = Database.database().reference()
        self.spaceKey = spaceKey
    }

    func addTask(taskName: String?) {
        guard taskName?.isEmpty != true else {
            emptyFields?()
            return
        }
        let newTopic = TaskTopic(name: taskName!, key: nil)
        ref?.child("Spaces").child(spaceKey!).child("Tasks").childByAutoId().setValue(newTopic.sendData())
        self.addTaskPressed?()

    }
}
