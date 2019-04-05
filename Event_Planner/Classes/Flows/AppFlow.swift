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
    fileprivate var rootController: UINavigationController?
    fileprivate var childFlow: FlowController?
    fileprivate var userService: PUserService?
    fileprivate var spaceService: PSpacesService?
    fileprivate var ideaService: PIdeaService?
    fileprivate var chatService: PChatService?
    fileprivate var taskService: PTaskService?
    fileprivate var budgetService: PBudgetService?


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
        let greetingFlow = GreetingFlow(with: rootController, userService: userService)
        greetingFlow.start()
        window.rootViewController = greetingFlow.greetingNavController
        greetingFlow.navigateToSpaces = { [weak self] in
            self?.navigateToSpacesFlow()
        }
        childFlow = greetingFlow
    }

    private func navigateToSpacesFlow() {
        let spacesFlow = SpacesFlow(rootController: rootController, userService: userService, spaceService: spaceService, ideaService: ideaService, chatService: chatService, taskService: taskService, budgetService: budgetService)
        spacesFlow.start()
        window.rootViewController = spacesFlow.rootController
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
    }
}
