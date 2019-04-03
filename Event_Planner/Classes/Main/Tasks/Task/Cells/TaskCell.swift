//
//  TaskCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    func displayContent(name: String?) {
        taskName.text = name
    }
}
