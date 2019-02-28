//
//  MainTabbarController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MainTabbarController: ClassName {
    static var className: String {
        return String(describing: self)
    }
}

protocol ClassName {
    static var className: String {get}
}
