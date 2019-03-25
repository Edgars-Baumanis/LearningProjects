//
//  InProgressDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class InProgressDetailsModel {
    private var ref: DatabaseReference?
    private var spaceKey: String?
    private var taskTopic: TaskTopic?
    var task: Task?
    var leavingInProgressDetails: (() -> Void)?

    init(spaceKey: String?, taskTopic: TaskTopic?, task: Task?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
        ref = Database.database().reference()
    }

    func taskDone() {
        let newTask = Task(name: (task?.name)!, description: (task?.description)!, key: nil, ownerID: (task?.ownerID)!, deadline: (task?.deadline)!)
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("Done").child((task?.key)!).setValue(newTask.sendData())
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("InProgress").child((task?.key)!).removeValue()
        self.leavingInProgressDetails?()
    }

    func deletePressed() {
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("InProgress").child((task?.key)!).removeValue()
        self.leavingInProgressDetails?()
    }
}
