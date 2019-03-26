//
//  AddTaskTopicModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddTaskTopicModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?
    
    var emptyFields: (()->Void)?
    var navigateToTaskTopic: (() -> Void)?

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
        self.navigateToTaskTopic?()

    }
}
