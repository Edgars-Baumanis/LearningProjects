//
//  UserProfileModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class UserProfileModel {
    private let userService: PUserService?

    var errorMessage: ((String?) -> Void)?
    var toEditAccount: (() -> Void)?
    var toLogin: (() -> Void)?
    let user: UserDO?

    init (userService: PUserService?) {
        self.userService = userService
        self.user = userService?.user
    }

    func logout() {
        userService?.signOut(completionHandler: { [weak self] (error) in
            if error != nil {
                guard let error = error as? String? else { return }
                self?.errorMessage?(error)
            } else {
                self?.toLogin?()
            }
        })
    }

    func deleteAcc() {
        userService?.deleteAcc(completionHandler: { [weak self] (error) in
            if error == nil {
                self?.toLogin?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
