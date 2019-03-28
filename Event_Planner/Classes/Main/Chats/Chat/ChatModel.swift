//
//  ChatModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatModel {
    
    private let userServices: PUserService?
    private let spaceKey: String?
    private let chatService: PChatService?

    var chat: ChatDO?
    var dataSource: [MessageDO] = []
    var dataSourceChanged: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    let currentUserID: String?

    init(chat: ChatDO?, userServices: PUserService?, spaceKey: String?, chatService: PChatService?) {
        self.chat = chat
        self.userServices = userServices
        self.spaceKey = spaceKey
        currentUserID = userServices?.user?.userID
        self.chatService = chatService
    } 

    func sendMessage(messageText: String?) {
        chatService?.sendMessage(spaceKey: spaceKey, chatKey: chat?.key, messageText: messageText, completionHandler: { (error) in
            if error != nil {
                self.errorMessage?(error)
            }
        })
    }

    func getMessages() {
        chatService?.getMessages(spaceKey: spaceKey, chatKey: chat?.key, completionHandler: { [weak self] (message, error) in
            if error == nil {
                guard let newMessage = message else { return }
                self?.dataSource.append(newMessage)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
