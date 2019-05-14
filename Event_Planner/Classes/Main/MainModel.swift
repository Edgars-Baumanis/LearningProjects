//
//  MainModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainModel {
    private let mainService: PMainService?
    private let userService: PUserService?
    var infoPressed: (() -> Void)?
    var chatPressed: (() -> Void)?
    var budgetPressed: (() -> Void)?
    var ideasPressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    var leaveSpace: (() -> Void)?
    var tasksPressed: (() -> Void)?
    var space: SpaceDO?

    init(_ mainService: PMainService?, _ userService: PUserService?) {
        self.mainService = mainService
        self.userService = userService
    }

    func leavePressed() {
        space?.users.enumerated().forEach({ (offSet, userID) in
            if userID == userService?.user?.userID {
                space?.users.remove(at: offSet)
            }
        })
        mainService?.leaveEvent(space: space, completionHandler: { [weak self] (error) in
            if let error = error {
                self?.errorMessage?(error)
            } else {
                self?.leaveSpace?()
            }
        })
    }
}
