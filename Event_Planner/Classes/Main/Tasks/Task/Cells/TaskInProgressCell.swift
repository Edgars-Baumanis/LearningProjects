//
//  TaskInProgressCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskInProgressCell: UITableViewCell {
    @IBOutlet weak var taskInProgress: UILabel!

    func displayContent(name: String) {
        taskInProgress.text = name
    }
}
