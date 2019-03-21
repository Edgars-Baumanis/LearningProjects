//
//  IdeaTopicStructure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct IdeaTopicStruct {
    var name: String
    var key: String?

    init(name: String, key: String?) {
        self.name = name
        self.key = key
    }

    func sendData() -> Any {
        return [
            "name": name
        ]
    }
}
