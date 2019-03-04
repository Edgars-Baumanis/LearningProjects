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
    private var ref: DatabaseReference?
    private var userService: MyUserServices?

    var backPressed: (()->Void)?
    
    init (userService: MyUserServices?) {
        ref = Database.database().reference()
        self.userService = userService
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true else {
            print("Please enter Space name and password")
            return
        }
        let newSpace = Space(spaceName: name!, spacePassword: password!)
        ref?.child("Spaces").child(name!).setValue(newSpace)
        
    }
    
    func printEmail() {
        userService?.printEmail()
    }
}
