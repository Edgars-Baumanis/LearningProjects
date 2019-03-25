//
//  MySpacesModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MySpacesModel {

    private var databaseHandle: DatabaseHandle?
    private var ref: DatabaseReference?
    private var userService: PUserService?

    var signingOut: (() -> Void)?
    var navigateToCreate: (() -> Void)?
    var mySpacesDataSource: [Space]?
    var otherSpacesDataSource: [Space]?
    var dataSourceChanged: (() -> Void)?
    var cellPressed: ((Space) -> Void)?

    init(userService: PUserService?) {
        mySpacesDataSource = []
        otherSpacesDataSource = []
        ref = Database.database().reference()
        self.userService = userService
    }
    
    func getData() {
        databaseHandle = ref?.child("Spaces").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let spaceName = post?["Name"] as? String,
                let uID = post?["Main User"] as? String,
                let spaceDesc = post?["Description"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newSpace = Space(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, mainUser: uID, key: key)
            if uID == self.userService?.user?.userID {
                self.mySpacesDataSource?.append(newSpace)
                self.dataSourceChanged?()
            } else {
                self.otherSpacesDataSource?.append(newSpace)
                self.dataSourceChanged?()
            }
        })
    }
}
