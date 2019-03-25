//
//  ChatsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ChatsModel {
    var addChatPressed: (()-> Void)?
    var dataSource: [String] = []
    var dataSourceChanged: (() -> Void)?
    var filteredDataSource: [String]?
    var cellClicked: ((_ chatName: String) -> Void)?
    private var databaseHandle: DatabaseHandle?
    private var ref: DatabaseReference?
    private var spaceName: String?


    init(spaceName: String?) {
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
        filteredDataSource = []
        self.spaceName = spaceName
    }

    func getChats() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Chats").observe(.childAdded, with: { (snapshot) in
            guard let post = snapshot.value as? [String : Any] else { return }
            guard
                let chatName = post["Name"] as? String
                else { return }
            self.dataSource.append(chatName)
            self.filteredDataSource?.append(chatName)
            self.dataSourceChanged?()
        })
    }
}
