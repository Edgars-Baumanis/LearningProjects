//
//  UserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class UserService: PUserService {
    private let firebaseAuth = Auth.auth()
    var user: User?
    
    func login(email: String, password: String, completionHandler: @escaping ((User?, String?) -> Void)) {
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
    
    func register(email: String, password: String, completionHandler: @escaping ((User?, String?) -> Void)) {
        if self.isValid(email: email) {
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
    }

    func signOut(completionHandler: @escaping ((NSError?) -> Void)) {
        do {
            try firebaseAuth.signOut()
            completionHandler(nil)
        } catch let signOutError as NSError {
            completionHandler(signOutError)
        }
    }

    private func isValid(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
}
