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
    private var space: SpaceDO?
    private var userService: PUserService?
    private var chat: ChatDO?
    private var chatService: PChatService?
    
    init(rootController: UINavigationController?, space: SpaceDO?, userServices: PUserService?, chatService: PChatService?) {
        self.rootController = rootController
        self.space = space
        self.userService = userServices
        self.chatService = chatService
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

    private var chatInfoController: ChatInfo? {
        return chatSB.instantiateViewController(withIdentifier: String(describing: ChatInfo.self)) as? ChatInfo
    }

    func start() {
        navigateToChats()
    }

    private func navigateToChats() {
        guard let vc = chatsViewController else { return }
        let viewModel = ChatsModel(spaceKey: space?.key, chatService: chatService)
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
        let viewModel = CreateChatModel(spaceKey: space?.key, chatService: chatService)
        viewModel.chatCreated = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChat() {
        guard let vc = chatController else { return }
        let viewModel = ChatModel(chat: chat, userServices: userService, spaceKey: space?.key, chatService: chatService)
        viewModel.infoPressed = { [weak self] in
            self?.navigateToChatInfo()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToChatInfo() {
        guard let vc = chatInfoController else { return }
        let viewModel = ChatInfoModel(chat: chat, userService: userService, space: space, chatService: chatService)
        viewModel.leaveScreen = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
