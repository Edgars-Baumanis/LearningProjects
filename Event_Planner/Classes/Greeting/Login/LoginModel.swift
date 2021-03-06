//
//  LoginModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class LoginModel {
    
    var loggedIn: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    var forgotPassword: (() -> Void)?
    var error: String?
    private var userService: PUserService?

    init(userService: PUserService?) {
        self.userService = userService
    }

    func loginUser(email: String?, password: String?) {
        error = "This is an error"

        userService?.login(email: email, password: password, completionHandler: { [weak self] (error)  in
            guard error == nil else {
                self?.errorMessage?(error)
                return
            }
            self?.loggedIn?()
            self?.error = "There is no error"
        })
    }
}
