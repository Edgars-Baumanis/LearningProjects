//
//  PSpaceService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PSpacesService {
    
    func getSpaces(completionHandler: @escaping ([SpaceDO]) -> Void)
    func createSpace(name: String?, password: String?, description: String?, completionHandler: (String?) -> Void)
    func joinSpace(space: SpaceDO?, completionHandler: @escaping (SpaceDO?, String?) -> Void)
    func reloadSpaces(completionHandler: @escaping (SpaceDO) -> Void)
    func getAllSpaces(completionHandler: @escaping ([SpaceDO]) -> Void)
}
