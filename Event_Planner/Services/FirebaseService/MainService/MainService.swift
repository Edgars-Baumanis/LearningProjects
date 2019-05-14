//
//  MainService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MainService: PMainService {
    let ref = Database.database().reference()
    let users = "Users"

    func getUsers(eventUsers: [String]?, completionHandler: @escaping ([UserDO]?, String?) -> Void) {
        guard let eventUsers = eventUsers else {
            completionHandler(nil, "No users found")
            return
        }
        ref.child(users).observe(.value) { (snapshot) in
            let post = snapshot.value as? [String: AnyObject]
            var users = [UserDO]()
            post?.forEach({ (user) in
                if eventUsers.contains(user.key) {
                    guard
                        let userName = user.value["userName"] as? String,
                        let userEmail = user.value["email"] as? String
                        else { return }
                    let newUser = UserDO(email: userEmail, userID: user.key, userName: userName)
                    users.append(newUser)
                }
            })
            completionHandler(users, nil)
        }
    }

    func deleteUser(spaceID: String?, remainingUsers: [UserDO]?, completionHandler: @escaping (String?) -> Void) {
        guard let spaceID = spaceID, let remainingUsers = remainingUsers else {
            completionHandler("problem with deletion")
            return
        }
        ref.child("Spaces").child(spaceID).child("users").setValue(remainingUsers)
        completionHandler(nil)
    }

    func leaveEvent(space: SpaceDO?, completionHandler: @escaping (String?) -> Void) {
        guard let space = space, let key = space.key else {
            completionHandler("bla")
            return
        }
        ref.child("Spaces").child(key).child("users").setValue(space.users)
        completionHandler(nil)
    }
}
