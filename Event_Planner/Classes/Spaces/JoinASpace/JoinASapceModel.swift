//
//  JoinASapceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct AddUser {
    let uID: String?

    init (uID: String) {
        self.uID = uID
    }

    func sendData() -> Any {
        return [
            "uID": uID
        ]
    }
}

class JoinASpaceModel {

    private var databaseHandle: DatabaseHandle?
    private var ref: DatabaseReference?
    private var spaceName: String?
    private var userService: PUserService?

    init(userService: PUserService?) {
        self.userService = userService
        ref = Database.database().reference()
    }

    var wrongEntry: (()-> Void)?
    var emptyFields: (()-> Void)?
    var rightEntry: ((Space)-> Void)?

    func joinASpace(enteredSpaceName: String?, enteredSpacePassword: String?) {
        guard enteredSpaceName?.isEmpty != true, enteredSpacePassword?.isEmpty != true else {
            emptyFields?()
            return
        }
        databaseHandle = ref?.child("Spaces").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]

            guard
                let spaceName = post?["name"] as? String,
                let spacePassword = post?["password"] as? String,
                let spaceDesc = post?["desription"] as? String,
                let uID = post?["uID"] as? String,
                let key = snapshot.key as? String
                else { return }
            if spaceName == enteredSpaceName && spacePassword == enteredSpacePassword {

                if uID != self.userService?.user?.userID {
                    guard let uID = self.userService?.user?.userID else {return}
                    let user = AddUser(uID: uID)
                    self.ref?.child("Spaces").child(key).child("Allowed Users").setValue(user.sendData())
                }
                let space = Space(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, mainUser: uID, key: key)
                self.rightEntry?(space)
            } else {
                self.wrongEntry?()
                return
            }
        })
    }
}
