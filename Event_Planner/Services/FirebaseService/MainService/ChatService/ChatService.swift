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
        guard let spaceKey = spaceKey else { return }
        ref.child(spaceString).child(spaceKey).child(chatsString).observe(.childAdded, with: {  (snapshot) in
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

        ref.child(spaceString).child(spaceKey).child(chatsString).observe(.childChanged) { (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let chatName = post?["Name"] as? String,
                let chatDesc = post?["Description"] as? String,
                let key = snapshot.key as? String,
                let user = post?["User"] as? String
                else { return }
            let newChat = ChatDO(chatName: chatName, chatDescription: chatDesc, user: user, key: key)
            completionHandler(newChat, nil)
        }
    }

    func createChat(chatName: String?, chatDesc: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void) {
        guard chatName?.isEmpty != true, chatDesc?.isEmpty != true else {
            completionHandler("Please enter chat name and/or chat description")
            return
        }
        guard let userID = Dependencies.instance.userService.user?.userID else { return }
        let newChat = ChatDO(chatName: chatName!, chatDescription: chatDesc!, user: userID, key: nil)
        ref.child(spaceString).child(spaceKey!).child(chatsString).childByAutoId().setValue(newChat.sendData())
        completionHandler(nil)
    }

    func getMessages(spaceKey: String?, chatKey: String?, completionHandler: @escaping (MessageDO?, String?) -> Void) {
        guard spaceKey?.isEmpty != true, chatKey?.isEmpty != true else { return }
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
        guard spaceKey?.isEmpty != true, chatKey?.isEmpty != true, let userID = Dependencies.instance.userService.user?.userID, let username = Dependencies.instance.userService.user?.userName else { return }
        guard messageText?.isEmpty != true else {
            completionHandler("Say something")
            return
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let currentTime = timeFormatter.string(from: Date())
        let sentMessage = MessageDO(name: username, message: messageText!, userID: userID, time: currentTime)
        ref.child(spaceString).child(spaceKey!).child(chatsString).child(chatKey!).child(messageString).childByAutoId().setValue(sentMessage.sendData())
        completionHandler(nil)
    }

    func saveData(chat: ChatDO, spaceKey: String?, completionHandler: @escaping (String?) -> Void) {
        guard let spaceKey = spaceKey, let chatKey = chat.key else { return }
        saveChat(chat: chat, spaceKey: spaceKey, chatKey: chatKey)
        completionHandler(nil)
    }

    private func saveChat(chat: ChatDO, spaceKey: String, chatKey: String) {
        ref.child(spaceString).child(spaceKey).child(chatsString).child(chatKey).child("Name").setValue(chat.chatName)
        ref.child(spaceString).child(spaceKey).child(chatsString).child(chatKey).child("User").setValue(chat.user)
        ref.child(spaceString).child(spaceKey).child(chatsString).child(chatKey).child("Description").setValue(chat.chatDescription)
    }
}
