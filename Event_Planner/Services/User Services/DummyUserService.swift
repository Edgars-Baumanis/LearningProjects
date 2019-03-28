//
//  DummyUserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class DumbUserService: PUserService {
    var user: User?

    func login(email: String, password: String, completionHandler: @escaping ((User?, String?) -> Void)) {
        if isValid(email: email) {
            let dummyUser = User(email: email, userID: "qwertyuioiuytrew")
            completionHandler(dummyUser, nil)
            self.user = dummyUser
        } else {
            completionHandler(nil, "Something went wrong!")
        }
    }

    func register(email: String, password: String, completionHandler: @escaping ((User?, String?) -> Void)) {
    }

    private func isValid(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }

    func signOut(completionHandler: @escaping ((NSError?) -> Void)) {
    }
}
