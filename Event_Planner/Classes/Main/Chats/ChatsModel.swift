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
    var filteredDataSource: [ChatDO] = []
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
                self?.dataSource.append(newChat)
                self?.filteredDataSource.append(newChat)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func searchTextChanged(searchText: String) {
        filteredDataSource = searchText.isEmpty ? dataSource : dataSource.filter { (item: ChatDO) -> Bool in
            return item.chatName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
