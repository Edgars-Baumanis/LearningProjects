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
    @IBOutlet weak var timeStamp: UILabel!
    
    func displayContent(message: MessageDO?) {
        chatterName.text = message?.name
        chatText.text = message?.message
        self.timeStamp.text = message?.time
    }
}
