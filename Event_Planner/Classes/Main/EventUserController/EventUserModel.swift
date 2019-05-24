//
//  EventUserModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class EventUserModel {
    private let space: SpaceDO?
    private let mainService: PMainService?
    private let userService: PUserService?

    var dataSource = [UserDO]()
    var errorMessage: ((String?) -> Void)?
    var dataSourceChanged: (() -> Void)?

    init(_ space: SpaceDO?,_ mainService: PMainService?, _ userService: PUserService?) {
        self.space = space
        self.mainService = mainService
        self.userService = userService
        getUsers()
    }

    private func getUsers() {
        mainService?.getUsers(eventUsers: space?.users, completionHandler: { [weak self] (users, error) in
            if error == nil {
                guard let users = users else { return }
                self?.dataSource = users
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func deleteUser(index: Int) {
        if dataSource[index].userID != space?.mainUser {
            mainService?.deleteUser(spaceID: space?.key, remainingUsers: dataSource, completionHandler: { [weak self] (error) in
                if error != nil {
                    self?.errorMessage?(error)
                } else {
                    self?.dataSource.remove(at: index)
                    self?.dataSourceChanged?()
                }
            }) 
        } else {
            errorMessage?("Cannot delete space owner")
        }
    }

    func isOwner(index: Int) -> Bool {
        if dataSource[index].userID == space?.mainUser {
            return true
        } else {
            return false
        }
    }

    func isOwner() -> Bool {
        if userService?.isOwner(userID: space?.mainUser) == true {
            return true
        } else {
            return false
        }
    }
}
