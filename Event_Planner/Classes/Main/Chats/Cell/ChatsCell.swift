//
//  ChatsCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatsCell: UITableViewCell {
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chat: UILabel!

    func displayContent(chatName: String?) {
        chat.text = chatName
        chatView.createGradient()
    }
}
