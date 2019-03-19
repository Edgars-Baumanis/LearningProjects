//
//  ChatModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

struct Message {
    let name: String
    let message: String

    init (name: String, message: String) {
        self.name = name
        self.message = message
    }

    func sendData() -> Any {
        return [
            "name": name,
            "message": message
        ]
    }
}

class ChatModel {
    var chatName: String?
    var dataSource: [Message] = []
    var dataSourceChanged: (() -> Void)?
    private let ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private let userServices: PUserService?
    private let spaceName: String?


    init(
        chatName: String?,
        userServices: PUserService?,
        spaceName: String?) {
            self.chatName = chatName
            self.userServices = userServices
            self.spaceName = spaceName
            ref = Database.database().reference()
            databaseHandle = DatabaseHandle()
    }

    func sendMessage(messageText: String?) {
        guard messageText?.isEmpty != true else { return }
        let sentMessage = Message(name: userServices?.user?.userID ?? "Default userID", message: messageText!)
        ref?.child("Spaces").child(spaceName!).child("Chats").child(chatName!).child("Messages").childByAutoId().setValue(sentMessage.sendData())
    }

    func getMessages() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Chats").child(chatName!).child("Messages").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let message = post?["message"] as? String
                else { return }
            let text = Message(name: name, message: message)
            self.dataSource.append(text)
            self.dataSourceChanged?()
        })
    }
}
