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

    private var spaceKey: String?
    private var taskTopic: TopicDO?
    private var ref: DatabaseReference?
    
    var task: TaskDO?
    var leaveDetails: (() -> Void)?

    init(task: TaskDO?, spaceKey: String?, taskTopic: TopicDO?) {
        self.spaceKey = spaceKey
        self.taskTopic = taskTopic
        self.task = task
        ref = Database.database().reference()
    }

    func deleteTask() {
        ref?.child("Spaces").child(spaceKey!).child("Tasks").child((taskTopic?.key)!).child("Done").child((task?.key)!).removeValue()
        self.leaveDetails?()
    }

}
