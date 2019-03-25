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
    private var spaceName: String?
    private var taskTopic: TaskTopic?
    var task: Task?
    var leavingNeedsDoingDetails: (() -> Void)?
    var calculateBoxHeight: (() -> Void)?

    init(spaceName: String?, taskTopic: TaskTopic?, task: Task?) {
        self.spaceName = spaceName
        self.taskTopic = taskTopic
        self.task = task
        ref = Database.database().reference()
    }

    func inProgressPressed() {
        let newTask = Task(name: (task?.name)!, description: (task?.description)!, key: nil)
        ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).child("InProgress").child((task?.key)!).setValue(newTask.sendData())

        ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").child((task?.key)!).removeValue()
        
        self.leavingNeedsDoingDetails?()
    }

    func deletePressed() {
        ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").child((task?.key)!).removeValue()
        self.leavingNeedsDoingDetails?()

    }
}

