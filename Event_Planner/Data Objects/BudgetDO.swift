//
//  BudgetDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct BudgetDO {
    var name: String
    var sum: String
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
