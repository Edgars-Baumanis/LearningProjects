//
//  UserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

struct User {
    
    var email: String?
}

protocol UserService {
    var user: User? { get }
    
    func emailAndPassword(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void))
    
}

class MyUserServices: UserService {
    var user: User?
    
    func emailAndPassword(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                completionHandler(nil, "Wrong credentionals!")
                return
            }
            var myUser = User()
            myUser.email = Auth.auth().currentUser?.email
            self.user = myUser
            
            completionHandler(myUser,nil)
        }
    }
    
    func printEmail() {
        print(user?.email)
    }
    
    
}
