//
//  TaskDoneCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskDoneCell: UITableViewCell {
    @IBOutlet weak var taskDone: UILabel!

    func displayContent(name: String) {
        taskDone.text = name
    }
}
