//
//  ChatCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var chatterName: UILabel!
    @IBOutlet weak var chatText: UILabel!
    func displayContent(chatter: String, sentText: String) {
        chatterName.text = "\(chatter):"
        chatText.text = "\(sentText)"
    }
}
