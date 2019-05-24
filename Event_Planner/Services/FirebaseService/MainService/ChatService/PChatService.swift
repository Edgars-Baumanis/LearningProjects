//
//  PChatService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PChatService {
    func getChats(spaceKey: String?, completionHandler: @escaping (ChatDO?, String?) -> Void)
    func createChat(chatName: String?, chatDesc: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void)
    func getMessages(spaceKey: String?, chatKey: String?, completionHandler: @escaping (MessageDO?, String?) -> Void)
    func sendMessage(spaceKey: String?, chatKey: String?, messageText: String?, completionHandler: (String?) -> Void)
     func saveData(chat: ChatDO, spaceKey: String?, completionHandler: @escaping (String?) -> Void)
}
