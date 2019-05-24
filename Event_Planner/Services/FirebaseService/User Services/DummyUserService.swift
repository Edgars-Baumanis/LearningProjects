//
//  DummyUserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class DumbUserService: PUserService {
    func changePassword(user: UserDO?, password: String, oldPassword: String, completionHandler: @escaping (String?) -> Void) {
        
    }


    func changeUserprofile(user: UserDO?, email: String, password: String, userName: String, completionhandler: @escaping (String?) -> Void) {
        
    }

    
    func resetPassword(email: String?, completionHandler: @escaping (String?) -> Void) {

    }


    func isOwner(userID: String?) -> Bool {
        return true
    }

    func deleteAcc(completionHandler: @escaping ((String?) -> Void)) {
    }


    var user: UserDO?

    func login(email: String?, password: String?, completionHandler: @escaping ((String?) -> Void)) {
        if isValid(email: email!) {
            let dummyUser = UserDO(email: email!, userID: "qwertyuioiuytrew", userName: "randomUserName")
            completionHandler(nil)
            self.user = dummyUser
        } else {
            completionHandler("Something went wrong!")
        }
    }

    func register(email: String?, password: String?, userName: String?, completionHandler: @escaping (( String?) -> Void)) {
    }

    private func isValid(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }

    func signOut(completionHandler: @escaping ((NSError?) -> Void)) {
    }

    func getUser(completionHandler: @escaping () -> Void) {
    }

    func isLoggedIn() -> Bool {
        return true
    }
}
