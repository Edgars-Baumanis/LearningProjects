//
//  Structure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct Chat {
    let chatName: String?
    let chatDescription: String?
    let user: String?

    init (chatName: String, chatDescription: String, user: String) {
        self.chatName = chatName
        self.chatDescription = chatDescription
        self.user = user
    }

    func sendData() -> Any {
        return [
            "Name": chatName,
            "Description": chatDescription,
            "User": user
        ]
    }
}
