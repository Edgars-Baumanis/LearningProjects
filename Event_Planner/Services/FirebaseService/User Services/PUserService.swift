//
//  PUserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit



protocol PUserService {
    var user: UserDO? { get set }

    func login(email: String?, password: String?, completionHandler: @escaping ((String?) -> Void))

    func register(email: String?, password: String?, userName: String?, completionHandler: @escaping ((String?) -> Void))

    func signOut(completionHandler: @escaping ((NSError?) -> Void))
    func getUser(completionHandler: @escaping () -> Void)
    func isLoggedIn() -> Bool
    func deleteAcc(completionHandler: @escaping ((String?) -> Void))
    func isOwner(userID: String?) -> Bool
    func resetPassword(email: String?, completionHandler: @escaping (String?) -> Void)
    func changeUserprofile(user: UserDO?, email: String, password: String, userName: String, completionhandler: @escaping (String?) -> Void)
    func changePassword(user: UserDO?, password: String, oldPassword: String, completionHandler: @escaping (String?) -> Void)
}
