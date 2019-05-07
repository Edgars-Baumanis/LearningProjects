//
//  AppFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
class AppFlow: FlowController {
    
    private var window: UIWindow
    private var rootController: UINavigationController?
    private var childFlow: FlowController?
    private var userService: PUserService?
    private var spaceService: PSpacesService?
    private var ideaService: PIdeaService?
    private var chatService: PChatService?
    private var taskService: PTaskService?
    private var budgetService: PBudgetService?
    
    
    init(with window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        userService = Dependencies.instance.userService
        chatService = ChatService()
        ideaService = IdeaService()
        spaceService = SpaceService()
        taskService = TaskService()
        budgetService = BudgetService()

    }
    
    func start() {
        guard let isLoggedIn = userService?.isLoggedIn() else { return }
        if isLoggedIn {
            self.navigateToSpacesFlow()
        } else {
            self.navigateToGreetingFlow()
        }
    }
    
    private func navigateToGreetingFlow() {
        let greetingFlow = GreetingFlow(with: rootController, userService: userService)
        greetingFlow.start()
        greetingFlow.navigateToSpaces = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        window.rootViewController = greetingFlow.rootController
        childFlow = greetingFlow
    }
    
    private func navigateToSpacesFlow() {
        let spacesFlow = SpacesFlow(rootController: rootController, userService: userService, spaceService: spaceService, ideaService: ideaService, chatService: chatService, taskService: taskService, budgetService: budgetService)
        spacesFlow.start()
        spacesFlow.logoutPressed = { [weak self] in
            self?.start()
        }
        window.rootViewController = spacesFlow.rootController
        childFlow = spacesFlow
    }

}
