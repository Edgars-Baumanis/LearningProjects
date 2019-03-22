//
//  CurrentUserCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CurrentUserCell: UITableViewCell {
    @IBOutlet weak var userMessage: UILabel!

    func displayContent(message: String) {
        userMessage.text = message
    }
}
