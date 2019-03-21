//
//  TaskAddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class TaskAddTaskModel {
    var emptyFields: (() -> Void)?
    var addTaskPressed: (() -> Void)?
    private var ref: DatabaseReference?
    private var spaceName: String?
    private var taskTopic: TaskTopic?

    init(spaceName: String?, taskTopic: TaskTopic?) {
        self.spaceName = spaceName
        self.taskTopic = taskTopic
        ref = Database.database().reference()
    }

    func addTask(taskName: String?, taskDescription: String?) {
        guard taskName?.isEmpty != true, taskDescription?.isEmpty != true else { return }
        let newTask = Task(name: taskName!, description: taskDescription!, key: nil)
        ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").childByAutoId().setValue(newTask.sendData())
        addTaskPressed?()
    }
}
