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
    var dateFormatter: DateFormatter?
    private var ref: DatabaseReference?
    private var spaceKey: String?
    private var taskTopic: TaskTopic?
    private var userServices: PUserService?

    init(spaceKey: String?, taskTopic: TaskTopic?, userServices: PUserService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.userServices = userServices
        dateFormatter = DateFormatter()
        dateFormatter?.dateStyle = .short
        dateFormatter?.timeStyle = .short
        ref = Database.database().reference()
    }

    func addTask(taskName: String?, taskDescription: String?, deadline: String?) {
        guard
            taskName?.isEmpty != true,
            taskDescription?.isEmpty != true,
            deadline?.isEmpty != true,
            let userID = userServices?.user?.userID
            else { return }
        let newTask = Task(name: taskName!, description: taskDescription!, key: nil, ownerID: userID, deadline: deadline!)
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").childByAutoId().setValue(newTask.sendData())
        addTaskPressed?()
    }
}
