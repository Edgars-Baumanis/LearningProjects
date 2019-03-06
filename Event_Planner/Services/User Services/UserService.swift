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
    var userID: String?
}

protocol PUserService {
    var user: User? { get }
    
    func login(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void))
    
    func register(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void))
}

class UserService: PUserService {
    var user: User?
    
    func login(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                completionHandler(nil, "Wrong credentionals!")
                return
            }
            var myUser = User()
            myUser.email = Auth.auth().currentUser?.email
            myUser.userID = Auth.auth().currentUser?.uid
            self.user = myUser
            
            completionHandler(myUser,nil)
        }
    }
    
    func register(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                completionHandler(nil, "Email already exists")
                return
            }
            var myUser = User()
            myUser.email = Auth.auth().currentUser?.email
            myUser.userID = Auth.auth().currentUser?.uid
            self.user = myUser
            
            completionHandler(myUser, nil)
        }
    }
    
    func printEmail() {
        print(user?.email)
    }
    
    
}
