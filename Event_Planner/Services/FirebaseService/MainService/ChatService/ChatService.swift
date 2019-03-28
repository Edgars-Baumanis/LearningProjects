//
//  ChatService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import Firebase

class ChatService: PChatService {

    private var ref = Database.database().reference()
    private var spaceString = "Spaces"
    private var chatsString = "Chats"
    private var messageString = "Messages"
    
    func getChats(spaceKey: String?, completionHandler: @escaping (ChatDO?, String?) -> Void) {
        guard spaceKey?.isEmpty != true else {
            completionHandler(nil, "Empty fields for database reference")
            return
        }
        ref.child(spaceString).child(spaceKey!).child(chatsString).observe(.childAdded, with: {  (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let chatName = post?["Name"] as? String,
                let chatDesc = post?["Description"] as? String,
                let key = snapshot.key as? String,
                let user = post?["User"] as? String
                else { return }
            let newChat = ChatDO(chatName: chatName, chatDescription: chatDesc, user: user, key: key)
            completionHandler(newChat, nil)
        })
    }

    func createChat(chatName: String?, chatDesc: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void) {
        guard chatName?.isEmpty != true, chatDesc?.isEmpty != true else {
            completionHandler("Please enter Space name and/or Space password and/or Space description")
            return
        }
        guard let userID = Dependencies.instance.userService.user?.userID else {
            completionHandler("Problem with userService")
            return
        }
        let newChat = ChatDO(chatName: chatName!, chatDescription: chatDesc!, user: userID, key: nil)
        ref.child(spaceString).child(spaceKey!).child(chatsString).childByAutoId().setValue(newChat.sendData())
        completionHandler(nil)
    }

    func getMessages(spaceKey: String?, chatKey: String?, completionHandler: @escaping (MessageDO?, String?) -> Void) {
        guard spaceKey?.isEmpty != true, chatKey?.isEmpty != true else {
            completionHandler(nil, "Empty fields for database reference")
            return
        }
        ref.child(spaceString).child(spaceKey!).child(chatsString).child(chatKey!).child(messageString).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let text = post?["message"] as? String,
                let time = post?["time"] as? String,
                let userID = post?["userID"] as? String
                else { return }
            let message = MessageDO(name: name, message: text, userID: userID, time: time)
            completionHandler(message, nil)
        })
    }

    func sendMessage(spaceKey: String?, chatKey: String?, messageText: String?, completionHandler: (String?) -> Void) {
        guard spaceKey?.isEmpty != true, chatKey?.isEmpty != true, let userID = Dependencies.instance.userService.user?.userID else {
            completionHandler("Empty fields for database reference")
            return
        }
        guard messageText?.isEmpty != true else { return }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let currentTime = timeFormatter.string(from: Date())
        let sentMessage = MessageDO(name: userID, message: messageText!, userID: userID, time: currentTime)
        ref.child(spaceString).child(spaceKey!).child(chatsString).child(chatKey!).child(messageString).childByAutoId().setValue(sentMessage.sendData())
        completionHandler(nil)
    }
}
