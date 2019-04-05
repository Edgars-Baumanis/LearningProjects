//
//  MySpacesModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MySpacesModel {

    private var userService: PUserService?
    private var spaceService: PSpacesService?
    
    var navigateToMainFlow: ((SpaceDO) -> Void)?
    var currentUser: String?
    var signingOut: (() -> Void)?
    var navigateToCreate: (() -> Void)?
    var spaces: [SpaceDO] = []
    var dataSourceChanged: (() -> Void)?
    var joinPressed: (() -> Void)?

    init(userService: PUserService?, spaceService: PSpacesService?) {
        self.userService = userService
        self.spaceService = spaceService
        currentUser = userService?.user?.userID
        getData()
        reloadData()
    }
    
    func getData() {
        spaceService?.getSpaces(completionHandler: { [weak self] spaces in
            self?.spaces = spaces
            self?.dataSourceChanged?()
        })
    }

    func reloadData() {
        spaceService?.reloadSpaces(completionHandler: { [weak self] newSpace in
            if self?.spaces.contains(where: { (space) -> Bool in
                space.key == newSpace.key
            }) == true { 
                return
            } else {
                self?.spaces.append(newSpace)
                self?.dataSourceChanged?()
            }
        })
    }

    func signOut() {
        userService?.signOut(completionHandler: { [weak self] error in
            if error == nil {
                self?.signingOut?()
            } else {
                print(error)
            }
        })
    }

    func mySpacePressed(section: Int, index: Int) {
        navigateToMainFlow?(spaces[index])
    }

    func isCurrentUser(index: Int) -> Bool {
        if spaces[index].mainUser == currentUser {
            return true
        } else {
            return false
        }
    }
}
