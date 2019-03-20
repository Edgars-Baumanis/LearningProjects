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
    private var spaceName: String?

    init(spaceName: String?) {
        ref = Database.database().reference()
        self.spaceName = spaceName
    }

    func createChat(name: String?, desc: String?) {
        guard name?.isEmpty != true, desc?.isEmpty != true else {
            emptyFields?()
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let newChat = Chat(chatName: name!, chatDescription: desc!, user: userID)
        ref?.child("Spaces").child(spaceName!).child("Chats").child(name!).setValue(newChat.sendData())
        chatCreated?()
    }
}
