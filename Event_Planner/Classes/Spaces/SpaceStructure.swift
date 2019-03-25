//
//  Structure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct Space {
    let spaceName: String
    let spacePassword: String?
    let spaceDescription: String
    let mainUser: String
    let key: String?

    init (spaceName: String, spacePassword: String?, spaceDescription: String, mainUser: String, key: String?) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
        self.spaceDescription = spaceDescription
        self.mainUser = mainUser
        self.key = key
    }

    func sendData() -> Any {
        return [
            "Name": spaceName,
            "Password": spacePassword,
            "Description": spaceDescription,
            "Main User": mainUser
        ]
    }
}
