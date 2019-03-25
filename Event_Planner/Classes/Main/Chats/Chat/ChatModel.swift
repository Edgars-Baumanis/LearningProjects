//
//  ChatModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class ChatModel {
    var chat: Chat?
    var dataSource: [Message] = []
    var dataSourceChanged: (() -> Void)?
    private let ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private let userServices: PUserService?
    private let spaceKey: String?
    var currentUserID: String?

    init(chat: Chat?, userServices: PUserService?, spaceKey: String?) {
        self.chat = chat
        self.userServices = userServices
        self.spaceKey = spaceKey
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
        currentUserID = userServices?.user?.userID
    }

    func sendMessage(messageText: String?) {
        guard messageText?.isEmpty != true else { return }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let currentTime = timeFormatter.string(from: Date())
        let sentMessage = Message(name: userServices?.user?.userID ?? "Default userID", message: messageText!, userID: currentUserID, time: currentTime)
        ref?.child("Spaces").child(spaceKey!).child("Chats").child((chat?.key)!).child("Messages").childByAutoId().setValue(sentMessage.sendData())
    }

    func getMessages() {
        databaseHandle = ref?.child("Spaces").child(spaceKey!).child("Chats").child((chat?.key)!).child("Messages").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let message = post?["message"] as? String,
                let time = post?["time"] as? String,
                let userID = post?["userID"] as? String
                else { return }
            
            let text = Message(name: name, message: message, userID: userID, time: time)
            self.dataSource.append(text)
            self.dataSourceChanged?()
        })
    }

}
