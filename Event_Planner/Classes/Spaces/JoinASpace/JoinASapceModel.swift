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
    var rightEntry: ((String)-> Void)?

    func joinASpace(spaceName: String?, spacePassword: String?) {
        guard spaceName?.isEmpty != true, spacePassword?.isEmpty != true else {
            emptyFields?()
            return
        }
        databaseHandle = ref?.child("Spaces").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]

            guard
                let name = post?["name"] as? String?,
                let password = post?["password"] as? String,
                let uID = post?["uID"] as? String else { return }
            if name == spaceName && password == spacePassword {
                if uID != self.userService?.user?.userID {
                    guard let uID = self.userService?.user?.userID else {return}
                    let user = AddUser(uID: uID)
                    self.ref?.child("Spaces").child(name!).child("Allowed Users").setValue(user.sendData())
                }
                self.rightEntry?(name!)
            } else {
                self.wrongEntry?()
                return
            }
        })
    }
}
