//
//  CreateChatModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class CreateChatModel {
    private var ref: DatabaseReference?
    var chatCreated: (() -> Void)?
    var emptyFields: (() -> Void)?
    private var spaceKey: String?

    init(spaceKey: String?) {
        ref = Database.database().reference()
        self.spaceKey = spaceKey
    }

    func createChat(name: String?, desc: String?) {
        guard name?.isEmpty != true, desc?.isEmpty != true else {
            emptyFields?()
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let newChat = Chat(chatName: name!, chatDescription: desc!, user: userID, key: nil)
        ref?.child("Spaces").child(spaceKey!).child("Chats").childByAutoId().setValue(newChat.sendData())
        chatCreated?()
    }
}
