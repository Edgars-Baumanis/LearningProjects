//
//  TaskCells.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskCells: UITableViewCell {
    @IBOutlet weak var taskCell: UILabel!
    
    func displayContent(taskName: String) {
        taskCell.text = taskName
    }
}
