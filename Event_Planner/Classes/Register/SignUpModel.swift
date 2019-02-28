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
    var signInPressed: (()-> Void)?
    
    func signUpUser(email: String?, password: String?) {
        guard email?.isEmpty != true, password?.isEmpty != true else {
            print("Please enter valid username and/or password")
            return
        }
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            guard error == nil else {
                print(error)
                return
            }
            self.signInPressed?()
        }
    }
}
