//
//  JoinASapceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import FirebaseDatabase

class JoinASpaceModel {


    private var databaseHandle: DatabaseHandle?
    private var ref: DatabaseReference?
    private var spaceName: String?

    init() {
        ref = Database.database().reference()
    }

    var wrongEntry: (()-> Void)?
    var emptyFields: (()-> Void)?
    var rightEntry: (()-> Void)?

    func joinASpace(spaceName: String?, spacePassword: String?) {
        guard spaceName?.isEmpty != true, spacePassword?.isEmpty != true else {
            emptyFields?()
            return
        }
        databaseHandle = ref?.child("Spaces").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]

            guard
                let name = post?["name"] as? String?,
                let password = post?["password"] as? String else { return }

            if name == spaceName && password == spacePassword {
                self.rightEntry?()
            } else {
                self.wrongEntry?()
                return
            }
        })
    }
}
