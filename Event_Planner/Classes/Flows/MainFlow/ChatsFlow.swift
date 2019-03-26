//
//  ChatsFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatsFlow: FlowController {
    private var rootController: UINavigationController?
    private var spaceKey: String?
    private var userServices: PUserService?
    private var chat: Chat?
    
    init(rootController: UINavigationController?, spaceKey: String?, userServices: PUserService?) {
        self.rootController = rootController
        self.spaceKey = spaceKey
        self.userServices = userServices
    }

    private lazy var chatsSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.ChatsSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var chatSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.ChatSB.rawValue, bundle: Bundle.main)
    }()

    private var chatsViewController: ChatsController? {
        return chatsSB.instantiateViewController(withIdentifier: String(describing: ChatsController.self)) as? ChatsController
    }

    private var addChatController: CreateChat? {
        return chatsSB.instantiateViewController(withIdentifier: String(describing: CreateChat.self)) as? CreateChat
    }

    private var chatController: ChatController? {
        return chatSB.instantiateViewController(withIdentifier: String(describing: ChatController.self)) as? ChatController
    }


    func start() {
        navigateToChats()
    }

    private func navigateToChats() {
        guard let vc = chatsViewController else { return }
        let viewModel = ChatsModel(spaceKey: spaceKey)
        viewModel.navigateToAddChat = { [weak self] in
            self?.navigateToAddChat()
        }
        viewModel.navigateToChat = { [weak self] cell in
            self?.chat = cell
            self?.navigateToChat()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddChat() {
        guard let vc = addChatController else { return }
        let viewModel = CreateChatModel(spaceKey: spaceKey)
        viewModel.chatCreated = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChat() {
        guard let vc = chatController else { return }
        let viewModel = ChatModel(chat: chat, userServices: userServices, spaceKey: spaceKey)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
