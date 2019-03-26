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
    
    private var ref: DatabaseReference?
    private var spaceKey: String?

    var navigateToAddChat: (()-> Void)?
    var dataSource: [Chat] = []
    var dataSourceChanged: (() -> Void)?
    var filteredDataSource: [Chat]?
    var navigateToChat: ((_ chatName: Chat?) -> Void)?


    init(spaceKey: String?) {
        ref = Database.database().reference()
        filteredDataSource = []
        self.spaceKey = spaceKey
    }

    func getChats() {
        ref?.child("Spaces").child(spaceKey!).child("Chats").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let chatName = post?["Name"] as? String,
                let chatDesc = post?["Description"] as? String,
                let key = snapshot.key as? String,
                let user = post?["User"] as? String
                else { return }
            let newChat = Chat(chatName: chatName, chatDescription: chatDesc, user: user, key: key)
            self.dataSource.append(newChat)
            self.filteredDataSource?.append(newChat)
            self.dataSourceChanged?()
        })
    }
}
