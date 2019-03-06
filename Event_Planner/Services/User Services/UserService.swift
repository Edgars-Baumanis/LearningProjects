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
    
    let email: String
    let userID: String
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
            guard
                error == nil,
                let email = Auth.auth().currentUser?.email,
                let uid = Auth.auth().currentUser?.uid
                else {
                completionHandler(nil, "Wrong credentionals!")
                return
            }
            let myUser = User(
                email: email,
                userID: uid)
            self.user = myUser
            
            completionHandler(myUser,nil)
        }
    }
    
    func register(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard
                error == nil,
                let email = Auth.auth().currentUser?.email,
                let uid = Auth.auth().currentUser?.uid
                else {
                completionHandler(nil, "Email already exists")
                return
            }
            let myUser = User(
                email: email,
                userID: uid)
            self.user = myUser
            
            completionHandler(myUser, nil)
        }
    }
    
    func printEmail() {
        print(user?.email)
    }
    
    
}
