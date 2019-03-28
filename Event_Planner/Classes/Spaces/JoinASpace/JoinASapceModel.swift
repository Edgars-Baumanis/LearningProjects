//
//  JoinASapceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceModel {

    private var userService: PUserService?
    private var spaceService: PSpacesService?

    init(userService: PUserService?, spaceService: PSpacesService?) {
        self.userService = userService
        self.spaceService = spaceService
    }

    var errorMessage: ((String?) -> Void)?
    var rightEntry: ((_ space: SpaceDO) -> Void)?

    func joinASpace(enteredSpaceName: String?, enteredSpacePassword: String?) {
        spaceService?.joinSpace(enteredSpaceName: enteredSpaceName, enteredSpacePassword: enteredSpacePassword, completionHandler: { [weak self] (space, error) in
            guard let newSpace = space else { return }
            error == nil ? self?.rightEntry?(newSpace) : self?.errorMessage?(error)
        })
    }
}
