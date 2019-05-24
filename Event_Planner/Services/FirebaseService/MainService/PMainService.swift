//
//  PMainServices.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PMainService {
    func getUsers(eventUsers: [String]?, completionHandler: @escaping ([UserDO]?, String?) -> Void)
    func deleteUser(spaceID: String?, remainingUsers: [UserDO]?, completionHandler: @escaping (String?) -> Void)
    func leaveEvent(space: SpaceDO?, completionHandler: @escaping (String?) -> Void)
    func deleteEvent(space: SpaceDO?, completionHandler: @escaping (String?) -> Void)
}
