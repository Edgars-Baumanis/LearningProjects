//
//  TaskAddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddTaskModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private var userServices: PUserService?

    var emptyFields: (() -> Void)?
    var addTaskPressed: (() -> Void)?
    var dateFormatter: DateFormatter?

    init(spaceKey: String?, taskTopic: TopicDO?, userServices: PUserService?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.userServices = userServices
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "EEEE, MMM d, yyyy"
        ref = Database.database().reference()
    }

    func addTask(taskName: String?, taskDescription: String?, deadline: String?) {
        guard
            taskName?.isEmpty != true,
            taskDescription?.isEmpty != true,
            deadline?.isEmpty != true,
            let userID = userServices?.user?.userID
            else { return }
        let newTask = TaskDO(name: taskName!, description: taskDescription!, key: nil, ownerID: userID, deadline: deadline!)
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("NeedsDoing").childByAutoId().setValue(newTask.sendData())
        addTaskPressed?()
    }
}
