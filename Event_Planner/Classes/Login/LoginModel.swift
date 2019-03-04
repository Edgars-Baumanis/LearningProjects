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
    
    func loginUser(email: String?, password: String?) {
        guard email?.isEmpty != true, password?.isEmpty != true else { return }
        Dependencies.instance.userService.emailAndPassword(email: email!, password: password!, completionHandler: { user, error  in
            guard error == nil else {
                self.wrongSignIn?()
                return
            }
            self.loggedIn?()
        })
    }
}
