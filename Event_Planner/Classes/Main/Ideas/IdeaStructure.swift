//
//  Structure.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct Idea {
    let ideaName: String
    let likeCount: Int
    let key: String?

    init(ideaName: String, likeCount: Int, key: String?) {
        self.ideaName = ideaName
        self.likeCount = likeCount
        self.key = key
    }

    func sendData() -> Any {
        return [
            "name": ideaName,
            "likes": likeCount
        ]
    }
}
