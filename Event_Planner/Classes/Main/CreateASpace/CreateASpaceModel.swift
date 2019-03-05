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
    private var userService: UserService?

    var backPressed: (()->Void)?
    
    init (userService: UserService?) {
        self.userService = userService
        ref = Database.database().reference()
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true, description?.isEmpty != true else {
            print("Please enter Space name and/or password and/or description")
            return
        }
        let newSpace = Space(spaceName: name!, spacePassword: password!, spaceDescription: description!)
        ref?.child("Spaces").child(name!).setValue(newSpace.sendData())
        
    }
    
    func printEmail() {
        userService?.printEmail()
    }
}
