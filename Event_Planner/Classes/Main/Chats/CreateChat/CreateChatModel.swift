//
//  CreateChatModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CreateChatModel {
    var chatCreated: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    private var spaceKey: String?
    private var chatService: PChatService?

    init(spaceKey: String?, chatService: PChatService?) {
        self.spaceKey = spaceKey
        self.chatService = chatService
    }

    func createChat(name: String?, desc: String?) {
        chatService?.createChat(chatName: name, chatDesc: desc, spaceKey: spaceKey, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.chatCreated?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
