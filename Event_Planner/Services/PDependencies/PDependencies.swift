//
//  PDependencies.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

protocol PDependencies {
    var userService: UserService { get }
}

class Dependencies: PDependencies {
    static var instance = Dependencies()
    var userService = UserService()
    var spaceService = SpaceService()
}
