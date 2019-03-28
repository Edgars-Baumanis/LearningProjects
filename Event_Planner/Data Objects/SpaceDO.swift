//
//  SpaceDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 27.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct SpaceDO {
    let spaceName: String
    let spacePassword: String?
    let spaceDescription: String
    var users: [String]
    let key: String?
    let mainUser: String

    init (spaceName: String, spacePassword: String?, spaceDescription: String, users: [String], key: String?, mainUser: String) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
        self.spaceDescription = spaceDescription
        self.users = users
        self.key = key
        self.mainUser = mainUser
    }

    func sendData() -> Any {
        return [
            "name": spaceName,
            "password": spacePassword,
            "description": spaceDescription,
            "users": users,
            "mainUser": mainUser
        ]
    }
}
