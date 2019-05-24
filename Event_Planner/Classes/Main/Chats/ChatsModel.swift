//
//  ChatsModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatsModel {
    
    private let spaceKey: String?
    private let chatService: PChatService?

    var navigateToAddChat: (()-> Void)?
    var dataSource: [ChatDO] = []
    var dataSourceChanged: (() -> Void)?
    var navigateToChat: ((_ chatName: ChatDO?) -> Void)?
    var errorMessage: ((String?) -> Void)?
    


    init(spaceKey: String?, chatService: PChatService?) {
        self.spaceKey = spaceKey
        self.chatService = chatService
        getChats()
    }

    func getChats() {
        chatService?.getChats(spaceKey: spaceKey, completionHandler: { [weak self] (chat, error) in
            if error == nil {
                guard let newChat = chat else { return }
                if self?.dataSource.contains(where: {$0.key == newChat.key}) == true {
                    self?.dataSource.enumerated().forEach({ (offset, chat) in
                        if chat.key == newChat.key {
                            self?.dataSource[offset] = newChat
                            self?.dataSourceChanged?()
                        }
                    })
                } else {
                    self?.dataSource.append(newChat)
                    self?.dataSourceChanged?()
                }
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
