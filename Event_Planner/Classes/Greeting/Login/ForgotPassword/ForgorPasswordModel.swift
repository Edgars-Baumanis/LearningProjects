//
//  ForgorPasswordModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class ForgorPasswordModel {
    private let userService: PUserService?

    var closePressed: (() -> Void)?
    var errorMessage: ((String, String?) -> Void)?

    init(userService: PUserService?) {
        self.userService = userService
    }

    func sendPasswordReset(_ email: String?) {
        userService?.resetPassword(email: email?.trimmingCharacters(in: .whitespacesAndNewlines), completionHandler: { [weak self] (error) in
            if let error = error {
                if error == "Please check your email" {
                    self?.errorMessage?("Success", error)
                } else {
                    self?.errorMessage?("There was a problem", error)
                }
            } else {
                self?.closePressed?()
            }
        })
    }
}
