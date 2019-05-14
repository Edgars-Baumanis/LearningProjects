//
//  EventUserCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class EventUserCell: UITableViewCell {
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var userName: UILabel!

    func displayContent(userName: String?) {
        cellBackground.setCellBackground()
        self.userName.text = userName
    }
}
