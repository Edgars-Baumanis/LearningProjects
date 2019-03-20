//
//  Structure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct TaskTopic {
    let name: String
    let description: String

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    func sendData() -> Any {
        return [
            "name": name,
            "description": description
        ]
    }
}
