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
    var signingOut: (()-> Void)?
    var navigateToCreate: (()-> Void)?
    var databaseHandle: DatabaseHandle?
    var ref: DatabaseReference?
    var mySpacesDataSource: [String] = []
    var otherSpacesDataSource: [String] = []
    var dataSourceChanged: (()-> Void)?
    private var userService: UserService?

    init(userService: UserService?) {
        ref = Database.database().reference()
        self.userService = userService
    }
    
    func getData() {
        databaseHandle = ref?.child("Spaces").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let spaceName = post?["name"] as? String,
                let uID = post?["uID"] as? String else {return}
            if uID == self.userService?.user?.userID {
                self.mySpacesDataSource.append(spaceName)
                self.dataSourceChanged?()
            } else {
                self.otherSpacesDataSource.append(spaceName)
                self.dataSourceChanged?()
            }
        })
    }
}
