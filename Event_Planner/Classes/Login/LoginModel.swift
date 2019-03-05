//
//  LoginModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class LoginModel {
    
    var loggedIn: (()-> Void)?
    var wrongSignIn: (()-> Void)?
    var emptyFields: (()-> Void)?
    private var userService: UserService?
    
    
    init(userService: UserService?) {
        self.userService = userService
    }
    
    func loginUser(email: String?, password: String?) {
        guard email?.isEmpty != true, password?.isEmpty != true else {
            emptyFields?()
            return
        }
        userService?.login(email: email!, password: password!, completionHandler: { (user, error)  in
            guard error == nil else {
                self.wrongSignIn?()
                return
            }
            self.loggedIn?()
        })
    }
}
