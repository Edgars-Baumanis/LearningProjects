//
//  CreateASpaceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class CreateASpaceModel {
    private var ref: DatabaseReference?
    private var userService: PUserService?

    var backPressed: (()->Void)?
    var emptyFields: (()->Void)?
    
    init (userService: PUserService?) {
        self.userService = userService
        ref = Database.database().reference()
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true, description?.isEmpty != true else {
            emptyFields?()
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let newSpace = Space(spaceName: name!, spacePassword: password!, spaceDescription: description!, mainUser: userID, key: nil)
        ref?.child("Spaces").childByAutoId().setValue(newSpace.sendData())
        backPressed?()
    }
    
    func printEmail() {
        print("User with id: \(userService?.user?.userID)  has reached this far")
    }
}
