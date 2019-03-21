//
//  PUserService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit


struct User {

    var email: String
    var userID: String
}

protocol PUserService {
    var user: User? { get set }

    func login(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void))

    func register(email: String, password: String, completionHandler: @escaping ((User?, String?)->Void))
}
