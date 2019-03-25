//
//  TaskStructure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct Task {
    let name: String
    let description: String
    let key: String?
    let ownerID: String
    let deadline: String

    init(name: String, description: String, key: String?, ownerID: String, deadline: String) {
        self.name = name
        self.description = description
        self.key = key
        self.ownerID = ownerID
        self.deadline = deadline
    }

    func sendData() -> Any {
        return  [
            "name": name,
            "description": description,
            "ownerID": ownerID,
            "deadline": deadline
        ]
    }
}
