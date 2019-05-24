//
//  ChatInfoModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 16.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

class ChatInfoModel {

    var errorMessage: ((String?) -> Void)?
    var leaveScreen: (() -> Void)?

    let chat: ChatDO?
    private let space: SpaceDO?
    private let userService: PUserService?
    private let chatService: PChatService?

    init(chat: ChatDO?, userService: PUserService?, space: SpaceDO?, chatService: PChatService?) {
        self.chat = chat
        self.userService = userService
        self.space = space
        self.chatService = chatService
    }

    func isOwner() -> Bool {
        if userService?.isOwner(userID: space?.mainUser) == true || userService?.isOwner(userID: chat?.user) == true {
            return true
        } else {
            return false
        }
    }

    func saveData(chatName: String?, chatDescription: String?) {
        guard
            let chatName = chatName,
            let chatDescription = chatDescription,
            let mainUser = chat?.user,
            !chatName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !chatDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            else {
                errorMessage?("Please enter chat name and/or description")
                return
        }
        let newChat = ChatDO(
            chatName: chatName.trimmingCharacters(in: .whitespacesAndNewlines),
            chatDescription: chatDescription.trimmingCharacters(in: .whitespacesAndNewlines),
            user: mainUser,
            key: chat?.key)
        chatService?.saveData(chat: newChat, spaceKey: space?.key, completionHandler: { [weak self] (error) in
            if let error = error {
                self?.errorMessage?(error)
            } else {
                self?.leaveScreen?()
            }
        })
    }
}
