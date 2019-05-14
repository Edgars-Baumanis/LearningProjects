//
//  EventOwnerCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class EventOwnerCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var username: UILabel!

    func displayContent(userName: String?) {
        cellBackground.setCellBackground()
        username.text = userName
    }
}
