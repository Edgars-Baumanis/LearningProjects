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
    var signingOut: (() -> Void)?
    var navigateToCreate: (() -> Void)?
    var mySpaces: [SpaceDO] = []
    var otherSpaces: [SpaceDO] = []
    var dataSourceChanged: (() -> Void)?

    init(userService: PUserService?, spaceService: PSpacesService?) {
        self.userService = userService
        self.spaceService = spaceService
        getData()
    }
    
    func getData() {
        spaceService?.getSpaces(completionHandler: { [weak self] (space, mySpace) in
            if mySpace {
                self?.mySpaces.append(space)
            } else {
                self?.otherSpaces.append(space)
            }
            self?.dataSourceChanged?()
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

    func mySpacePressed(index: Int) {
        navigateToMainFlow?(mySpaces[index])
    }

    func otherSpacePressed(index: Int) {
        navigateToMainFlow?(otherSpaces[index])
    }
}
