//
//  JoinASapceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceModel {
    var emptyFields: (()-> Void)?
    func joinASpace(name: String?, password: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true else {
            emptyFields?()
            return
        }
    }
}
