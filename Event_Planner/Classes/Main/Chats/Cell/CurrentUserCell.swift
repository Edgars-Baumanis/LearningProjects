//
//  CurrentUserCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CurrentUserCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMessage: UILabel!
    
    func displayContent(user: String, message: String) {
        userName.text = user
        userMessage.text = message
    }
}
