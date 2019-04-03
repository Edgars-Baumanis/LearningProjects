//
//  CreateASpaceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CreateASpaceModel {
    private var userService: PUserService?
    private var spaceService: PSpacesService?

    var backPressed: (() -> Void)?
    var emptyFields: ((String?) -> Void)?
    
    init (userService: PUserService?, spaceService: PSpacesService?) {
        self.userService = userService
        self.spaceService = spaceService
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        spaceService?.createSpace(name: name, password: password, description: description, completionHandler: { [weak self] (error) in
            error == nil ?
                self?.backPressed?() :
                self?.emptyFields?(error)
        })
    }
}
