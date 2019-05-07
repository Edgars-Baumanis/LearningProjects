//
//  EditAccountModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class EditAccountModel {
    private let userService: PUserService?
    var user: UserDO?

    init(userService: PUserService?) {
        self.userService = userService
        self.user = userService?.user
    }

    func changeAccDetails(newEmail: String?, newUsername: String?) {
        
    }
}
