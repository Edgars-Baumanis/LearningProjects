//
//  ChangePasswordModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 02.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class ChangePasswordModel {
    private let userService: PUserService?
    private let user: UserDO?

    var errorMessage: ((String) -> Void)?
    var goToUserProfile: (() -> Void)?

    init(userService: PUserService?) {
        self.userService = userService
        user = userService?.user
    }

    func changePassword(to password: String?, repeatedNewPassword: String?, oldPassword: String?) {
        guard
            let password = password?.trimmingCharacters(in: .whitespacesAndNewlines),
            let secondPassword = repeatedNewPassword?.trimmingCharacters(in: .whitespacesAndNewlines),
            let oldPassword = oldPassword?.trimmingCharacters(in: .whitespacesAndNewlines)
            else {
                errorMessage?("Please enter empty fields!")
                return
        }
        guard
            password == secondPassword else {
                errorMessage?("Re-entered password does not match")
                return
        }
        userService?.changePassword(user: user, password: password, oldPassword: oldPassword, completionHandler: { [weak self] (error) in
            if let error = error {
                self?.errorMessage?(error)
            } else {
                self?.goToUserProfile?()
            }
        })
    }
}
