//
//  Structure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct Space {
    let spaceName: String?
    let spacePassword: String?
    let spaceDescription: String?
    let mainUser: String?

    init (spaceName: String, spacePassword: String, spaceDescription: String, mainUser: String) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
        self.spaceDescription = spaceDescription
        self.mainUser = mainUser
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
