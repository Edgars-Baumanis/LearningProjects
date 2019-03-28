//
//  TaskNeedsDoingCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskNeedsDoingCell: UITableViewCell {
    @IBOutlet weak var taskNeedsDoing: UILabel!

    func displayContent(name: String?) {
        taskNeedsDoing.text = name
    }
}
