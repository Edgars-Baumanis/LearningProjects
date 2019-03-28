//
//  PSpaceService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PSpacesService {
    
    func getSpaces(completionHandler: @escaping (SpaceDO, Bool) -> Void)
    func createSpace(name: String?, password: String?, description: String?, completionHandler: (String?) -> Void)
    func joinSpace(enteredSpaceName: String?, enteredSpacePassword: String?, completionHandler: @escaping (SpaceDO?, String?) -> Void)
}
