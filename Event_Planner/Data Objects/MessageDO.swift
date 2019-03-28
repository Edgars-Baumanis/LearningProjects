//
//  MessageDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct MessageDO {
    let name: String
    let message: String
    let userID: String
    let time: String

    init (name: String, message: String, userID: String, time: String) {
        self.name = name
        self.message = message
        self.userID = userID
        self.time = time
    }

    func sendData() -> Any {
        return [
            "name": name,
            "message": message,
            "userID": userID,
            "time": time
        ]
    }
}
