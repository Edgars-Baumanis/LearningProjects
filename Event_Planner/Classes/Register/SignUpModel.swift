//
//  SignUpModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class SignUpModel {
    var signUpPressed: (()-> Void)?
    var existingEmail: (()-> Void)?
    
    func signUpUser(email: String?, password: String?) {
        guard email?.isEmpty != true, password?.isEmpty != true else {
            print("Please enter valid username and/or password")
            return
        }
        Dependencies.instance.userService.register(email: email!
            , password: password!, completionHandler: { (user, error) in
        guard error == nil else {
                self.existingEmail?()
                return
            }
            self.signUpPressed?()
        })
    }
}
