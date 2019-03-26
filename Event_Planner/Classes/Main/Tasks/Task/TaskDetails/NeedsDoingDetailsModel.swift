//
//  NeedsDoingDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class NeedsDoingDetailsModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?
    private var taskTopic: TaskTopic?
    
    var task: Task?
    var leaveDetails: (() -> Void)?
    var calculateBoxHeight: (() -> Void)?

    init(spaceKey: String?, taskTopic: TaskTopic?, task: Task?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
        ref = Database.database().reference()
    }

    func inProgressPressed() {
        let newTask = Task(name: (task?.name)!, description: (task?.description)!, key: nil, ownerID: (task?.ownerID)!, deadline: (task?.deadline)!)
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("InProgress").child((task?.key)!).setValue(newTask.sendData())

        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").child((task?.key)!).removeValue()
        
        self.leaveDetails?()
    }

    func deletePressed() {
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").child((task?.key)!).removeValue()
        self.leaveDetails?()

    }
}

