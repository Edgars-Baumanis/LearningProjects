//
//  TasksCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 11.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksCell: UITableViewCell {
    @IBOutlet weak var task: UILabel!

    func displayContent(taskName: String?) {
        task.text = taskName
    }
}
