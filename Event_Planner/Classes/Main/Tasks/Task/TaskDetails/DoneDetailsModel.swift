//
//  DoneDetailsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class DoneDetailsModel {
    private var spaceName: String?
    private var taskTopic: TaskTopic?
    private var ref: DatabaseReference?
    var task: Task?
    var deletePressed: (() -> Void)?

    init(task: Task?, spaceName: String?, taskTopic: TaskTopic?) {
        self.spaceName = spaceName
        self.taskTopic = taskTopic
        self.task = task
        ref = Database.database().reference()
    }

    func deleteTask() {
        ref?.child("Spaces").child(spaceName!).child("Tasks").child((taskTopic?.key)!).child("Done").child((task?.key)!).removeValue()
        self.deletePressed?()
    }

}
