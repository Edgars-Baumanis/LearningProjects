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
    var existingEmail: (() -> Void)?
    var emptyFields: (() -> Void)?
    private var userService: PUserService?
    
    init(userService: PUserService?) {
        self.userService = userService
    }
    
    func signUpUser(email: String?, password: String?, userName: String?) {
        guard email?.isEmpty != true, password?.isEmpty != true, userName?.isEmpty != true else {
            emptyFields?()
            return
        }
        userService?.register(email: email!, password: password!, userName: userName!, completionHandler: { (user, error) in
        guard error == nil else {
                self.existingEmail?()
                return
            }
            self.navigateToSpaces?()
        })
    }
}
