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
    var errorMessage: ((String?) -> Void)?
    var goToUserProfile: (() -> Void)?
    var user: UserDO?

    init(userService: PUserService?) {
        self.userService = userService
        self.user = userService?.user
    }

    func changeAccDetails(newEmail: String?, newUsername: String?, password: String?) {
        guard
            let email = newEmail?.trimmingCharacters(in: .whitespacesAndNewlines),
            let username = newUsername?.trimmingCharacters(in: .whitespacesAndNewlines),
            let password = password?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty,
            !username.isEmpty,
            !password.isEmpty
            else {
                errorMessage?("Please enter email and/or username")
                return
        }
        userService?.changeUserprofile(user: user, email: email, password: password, userName: username, completionhandler: { [weak self] (error) in
            if let errror = error {
                self?.errorMessage?(error)
            } else {
                self?.goToUserProfile?()
            }
        })
    }
}
