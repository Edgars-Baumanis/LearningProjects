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
    private let ref = Database.database().reference()
    private let usersString = "Users"
    var user: UserDO?
    
    func login(email: String?, password: String?, completionHandler: @escaping ((String?) -> Void)) {
        guard email?.isEmpty != true, password?.isEmpty != true else {
            completionHandler("Empty fields")
            return
        }
        firebaseAuth.signIn(withEmail: email!, password: password!) { [weak self] (user, error) in
            guard
                error == nil,
                let loginEmail = self?.firebaseAuth.currentUser?.email,
                let loginUserID = self?.firebaseAuth.currentUser?.uid
            
                else {
                    completionHandler("Wrong credentials")
                    return
            }
            guard let usersString = self?.usersString else { return }
            self?.ref.child(usersString).observeSingleEvent(of: .value, with: { (snapshot) in
                let post = snapshot.value as? [String : Any]
                guard
                    let userThings = post?["\(loginUserID)"] as? [String : Any],
                    let userName = userThings["userName"] as? String,
                    let userID = userThings["userID"] as? String,
                    let email = userThings["email"] as? String
                    else { return }
                if loginEmail == email && loginUserID == userID {
                    let myUser = UserDO(email: email, userID: userID, userName: userName)
                    self?.user = myUser
                    completionHandler(nil)
                }
            })
        }
    }
    
    func register(email: String?, password: String?, userName: String?, completionHandler: @escaping ((String?) -> Void)) {

        guard email?.isEmpty != true, password?.isEmpty != true, userName?.isEmpty != true else {
            completionHandler("Empty Fields")
            return
        }

        if self.isValid(email: email!) {
            Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] (user, error) in
                guard
                    error == nil,
                    let email = self?.firebaseAuth.currentUser?.email,
                    let uid = self?.firebaseAuth.currentUser?.uid
                    else {
                        print(error)
                        completionHandler("Email already exists")
                        return
                }
                guard let usersString = self?.usersString else { return }
                let myUser = UserDO(email: email, userID: uid, userName: userName!)
                self?.user = myUser
                self?.ref.child(usersString).child(uid).setValue(myUser.sendData())
                completionHandler(nil)
            }
        } else {
            completionHandler("Email badly formated")
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

    func getUser(completionHandler: @escaping () -> Void) {
        guard let userID = firebaseAuth.currentUser?.uid
            else { return }
        ref.child(usersString).child(userID).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let username = post?["userName"] as? String,
                let userID = post?["userID"] as? String,
                let email = post?["email"] as? String
                else { return }
            let user = UserDO(email: email, userID: userID, userName: username)
            self?.user = user
            completionHandler()
        }
    }

    func isLoggedIn() -> Bool {
        if firebaseAuth.currentUser == nil {
            return false
        } else {
            return true
        }
    }

    func deleteAcc(completionHandler: @escaping ((String?) -> Void)) {
        firebaseAuth.currentUser?.delete(completion: { (error) in
            if error == nil {
                completionHandler(nil)
            } else {
                guard let error = error as? String else { return }
                completionHandler(error)
            }
        })
    }

    func isOwner(userID: String?) -> Bool {
        if firebaseAuth.currentUser?.uid == userID {
            return true
        } else {
            return false
        }
    }

    func resetPassword(email: String?, completionHandler: @escaping (String?) -> Void) {
        guard let email = email, !email.isEmpty else {
            completionHandler("Please enter email to send password reset to")
            return
        }
        firebaseAuth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error as? String {
                completionHandler(error)
            } else {
                completionHandler("Please check your email")
            }
        }
    }

    func changeUserData(newUser: UserDO?, completionHandler: @escaping (String?) -> Void) {
        
    }
}
