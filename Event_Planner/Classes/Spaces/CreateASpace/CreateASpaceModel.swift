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

struct Space {
    let spaceName: String?
    let spacePassword: String?
    let spaceDescription: String?
    let uID: String?

    init (spaceName: String, spacePassword: String, spaceDescription: String, uID: String) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
        self.spaceDescription = spaceDescription
        self.uID = uID
    }

    func sendData() -> Any {
        return [
            "name": spaceName,
            "password": spacePassword,
            "description": spaceDescription,
            "uID": uID
        ]
    }
}

class CreateASpaceModel {
    private var ref: DatabaseReference?
    private var userService: PUserService?

    var backPressed: (()->Void)?
    
    init (userService: PUserService?) {
        self.userService = userService
        ref = Database.database().reference()
    }
    
    func createASpace(name: String?, password: String?, description: String?) {
        guard name?.isEmpty != true, password?.isEmpty != true, description?.isEmpty != true else {
            print("Please enter Space name and/or password and/or description")
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let newSpace = Space(spaceName: name!, spacePassword: password!, spaceDescription: description!, uID: userID)
        ref?.child("Spaces").child(name!).setValue(newSpace.sendData())
        backPressed?()
    }
    
    func printEmail() {
        print("User with id: \(userService?.user?.userID)  has reached this far")
    }
}