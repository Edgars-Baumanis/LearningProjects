//
//  UserDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 05.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct UserDO {
    var email: String
    var userID: String
    var userName: String

    init(email: String, userID: String, userName: String) {
        self.email = email
        self.userID = userID
        self.userName = userName
    }

    func sendData() -> Any {
        return [
            "email": email,
            "userID": userID,
            "userName": userName
        ]
    }
}
