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

    private lazy var spacesVC: MySpacesVC? = {
        return UIStoryboard(name: Strings.SpacesSB.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MySpacesVC.self)) as? MySpacesVC
    }()
    
    func start() {
        guard let isLoggedIn = userService?.isLoggedIn(), let spacesVC = spacesVC else { return }
        rootController = UINavigationController(rootViewController: spacesVC)
        window.rootViewController = rootController
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
        childFlow = greetingFlow
    }
    
    private func navigateToSpacesFlow() {
        let spacesFlow = SpacesFlow(rootController: rootController, userService: userService, spaceService: spaceService, ideaService: ideaService, chatService: chatService, taskService: taskService, budgetService: budgetService, spacesVC: spacesVC)
        spacesFlow.start()
        childFlow = spacesFlow
        spacesFlow.logoutPressed = { [weak self] in
            self?.navigateToGreetingFlow()
        }
    }
}
