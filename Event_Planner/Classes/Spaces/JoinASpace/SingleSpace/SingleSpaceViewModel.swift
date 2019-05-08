
//
//  SingleSpaceViewModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 07.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class SingleSpaceViewModel {
    var closePressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    var rightEntry: ((_ space: SpaceDO) -> Void)?
    
    var space: SpaceDO?
    private let spaceService: PSpacesService?

    init(space: SpaceDO?, spaceService: PSpacesService?) {
        self.space = space
        self.spaceService = spaceService
    }

    func joinASpace(password: String?) {
        guard
            password == space?.spacePassword
            else {
                errorMessage?("Wrong password")
                return
        }
        spaceService?.joinSpace(space: space, completionHandler: { [weak self] (space, error) in
            if error == nil {
                guard let space = space else { return }
                self?.rightEntry?(space)
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
