//
//  ChatDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct ChatDO {
    let chatName: String
    let chatDescription: String
    let user: String?
    let key: String?

    init (chatName: String, chatDescription: String, user: String, key: String?) {
        self.chatName = chatName
        self.chatDescription = chatDescription
        self.user = user
        self.key = key
    }

    func sendData() -> Any {
        return [
            "Name": chatName,
            "Description": chatDescription,
            "User": user
        ]
    }
}
