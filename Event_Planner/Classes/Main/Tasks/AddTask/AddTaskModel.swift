//
//  AddTaskModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTaskModel {
    var emptyFields: (()->Void)?

    func addTask(taskName: String?, taskDescription: String?) {
        guard taskName?.isEmpty != true, taskDescription?.isEmpty != true else {
            return
        }
    }
}
