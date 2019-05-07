//
//  PresentableTaskDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 02.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct PresentableTaskDO {
    var tasks: [TaskDO]
    var isExpanded: Bool

    init(tasks: [TaskDO], isExpanded: Bool) {
        self.tasks = tasks
        self.isExpanded = isExpanded
    }
}
