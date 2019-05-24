//
//  SignUpModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SignUpModel {
    var navigateToSpaces: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    private var userService: PUserService?
    
    init(userService: PUserService?) {
        self.userService = userService
    }
    
    func signUpUser(email: String?, password: String?, userName: String?) {

        userService?.register(
            email: email,
            password: password?.trimmingCharacters(in: .whitespacesAndNewlines),
            userName: userName?.trimmingCharacters(in: .whitespacesAndNewlines),
            completionHandler: { [weak self] (error) in
        guard error == nil else {
                self?.errorMessage?(error)
                return
            }
            self?.navigateToSpaces?()
        })
    }
}
