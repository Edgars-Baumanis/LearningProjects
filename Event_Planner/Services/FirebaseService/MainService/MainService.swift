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
    private let ref = Database.database().reference()
    private let users = "Users"
    private let spaces = "Spaces"
    private let spaceUsers = "users"

    func getUsers(eventUsers: [String]?, completionHandler: @escaping ([UserDO]?, String?) -> Void) {
        guard let eventUsers = eventUsers else { return }
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
        guard let spaceID = spaceID, let remainingUsers = remainingUsers else { return }
        ref.child(spaces).child(spaceID).child(spaceUsers).setValue(remainingUsers)
        completionHandler(nil)
    }

    func leaveEvent(space: SpaceDO?, completionHandler: @escaping (String?) -> Void) {
        guard let space = space, let key = space.key else { return }
        ref.child(spaces).child(key).child(spaceUsers).setValue(space.users)
        completionHandler(nil)
    }

    func deleteEvent(space: SpaceDO?, completionHandler: @escaping (String?) -> Void) {
        guard let key = space?.key else { return }
        ref.child(spaces).child(key).removeValue()
        completionHandler(nil)
    }
}
