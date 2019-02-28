//
//  CreateASpaceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateASpaceModel {
    var ref: DatabaseReference?
    var backPressed: (()->Void)?
    
    init () {
        ref = Database.database().reference()
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true else {
            print("Please enter Space name and password")
            return
        }
        let newSpace = Space(spaceName: name!, spacePassword: password!)
        ref?.child("Spaces").child(name!).setValue(newSpace)
        
    }
}
