//
//  File.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

struct BudgetField {
    var name: String?
    var sum: String?
    var key: String?

    init(name: String, sum: String, key: String?) {
        self.name = name
        self.sum = sum
        self.key = key
    }

    func sendData() -> Any {
        return [
            "name": name,
            "sum": sum
        ]
    }
}
