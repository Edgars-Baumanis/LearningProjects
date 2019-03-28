//
//  AppFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase
class AppFlow: FlowController {
    
    fileprivate var window: UIWindow
    fileprivate var rootController = UITabBarController()
    fileprivate var childFlow: FlowController?
    fileprivate var userService: PUserService?
    fileprivate var spaceService: PSpacesService?
    fileprivate var ideaService: PIdeaService?
    fileprivate var chatService: PChatService?
    fileprivate var taskService: PTaskService?

    init(with window: UIWindow) {
        self.window = window

        window.makeKeyAndVisible()
        userService = Dependencies.instance.userService
        chatService = ChatService()
        ideaService = IdeaService()
        spaceService = SpaceService()
        taskService = TaskService()
    }

    func start() {
        if Auth.auth().currentUser != nil {
            guard
                let userID = Auth.auth().currentUser?.uid,
                let email = Auth.auth().currentUser?.email
                else { return }
            self.userService?.user = User(email: email, userID: userID)
            self.navigateToSpacesFlow()
        } else {
            self.navigateToGreetingFlow()
        }
    }

    private func navigateToGreetingFlow() {
        window.rootViewController = rootController
        let greetingFlow = GreetingFlow(with: rootController, userService: userService)
        greetingFlow.start()
        greetingFlow.navigateToSpaces = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        childFlow = greetingFlow
    }

    private func navigateToSpacesFlow() {
        window.rootViewController = rootController
        let spacesFlow = SpacesFlow(with: rootController, userService: userService, spaceService: spaceService)
        spacesFlow.start()
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
        spacesFlow.cellPressed = { [weak self] space in
            self?.navigateToMainFlow(space: space)
        }
    }

    private func navigateToMainFlow(space: SpaceDO?) {
        let mainFlow = MainFlow(with: rootController, with: userService, ideaService: ideaService, space: space, chatService: chatService, taskService: taskService)
        mainFlow.start()
        mainFlow.navigateToSpacesFlow = { [weak self] in
            self?.start()
        }
        childFlow = mainFlow
    }
}
