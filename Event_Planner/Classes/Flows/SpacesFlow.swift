//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {
    
    var logoutPressed: (()->Void)?
    var rootController: UINavigationController?
    private var deleteVM: (() -> Void)?
    private var userService: PUserService?
    private var spaceService: PSpacesService?
    private var ideaService: PIdeaService?
    private var chatService: PChatService?
    private var taskService: PTaskService?
    private var budgetService: PBudgetService?
    private var childFlow: FlowController?
    private var mainService: PMainService?

    
    init (rootController: UINavigationController?, userService: PUserService?, spaceService: PSpacesService?, ideaService: PIdeaService?, chatService: PChatService?, taskService: PTaskService?, budgetService: PBudgetService?, mainService: PMainService?) {
        self.rootController = rootController
        self.userService = userService
        self.spaceService = spaceService
        self.ideaService = ideaService
        self.chatService = chatService
        self.taskService = taskService
        self.budgetService = budgetService
        self.mainService = mainService
    }

    private lazy var userSB: UIStoryboard = {
        return UIStoryboard(name: Strings.UserProfile.rawValue, bundle: Bundle.main)
    }()
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: Strings.SpacesSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var spacesVC: MySpacesVC? = {
        return UIStoryboard(name: Strings.SpacesSB.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MySpacesVC.self)) as? MySpacesVC
    }()
    
    private lazy var joinVC: JoinASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: JoinASpaceController.self)) as? JoinASpaceController
    }()
    
    private lazy var createVC: CreateASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: CreateASpaceController.self)) as? CreateASpaceController
    }()

    private lazy var userProfileVC: UserProfileVC? = {
        return userSB.instantiateViewController(withIdentifier: String(describing: UserProfileVC.self)) as? UserProfileVC
    }()

    private lazy var editProfileVC: EditAccountVC? = {
        return userSB.instantiateViewController(withIdentifier: String(describing: EditAccountVC.self)) as? EditAccountVC
    }()

    private lazy var singleSpaceVC: SingleSpaceVC? = {
        return mainSB.instantiateViewController(withIdentifier: String(describing: SingleSpaceVC.self)) as? SingleSpaceVC
    }()

    func start() {
        guard let vc = spacesVC else { return }
        let spacesViewModel = MySpacesModel(userService: userService, spaceService: spaceService)
        spacesViewModel.signingOut = { [weak self] in
            self?.logoutPressed?()
        }
        spacesViewModel.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
        spacesViewModel.navigateToMainFlow = { [weak self] space in
            self?.navigateToMainFlow(space: space)
        }
        spacesViewModel.joinPressed = { [weak self] in
            self?.navigateToJoin()
        }
        spacesViewModel.toProfile = { [weak self] in
            self?.navigateToProfile()
        }

        vc.viewModel = spacesViewModel
        rootController = UINavigationController(rootViewController: vc)
    }

    private func navigateToJoin() {
        guard let joinVC = joinVC else {return}
        let joinViewModel = JoinASpaceModel(userService: userService, spaceService: spaceService)

        joinViewModel.backPressed = { [weak self] in
            joinVC.viewModel = nil
            self?.rootController?.popViewController(animated: true)
        }
        joinViewModel.spacePressed = { [weak self] (space) in
            guard let self = self else { return }
            self.deleteVM = {
                joinVC.viewModel = nil
            }
            self.navigateToJoinSingleSpace(space: space)
        }
        joinVC.viewModel = joinViewModel
        rootController?.pushViewController(joinVC, animated: true)
    }

    private func navigateToCreate() {
        guard let vc = createVC else { return }
        vc.viewModel = CreateASpaceModel(userService: userService, spaceService: spaceService)
        vc.viewModel?.backPressed = { [weak self] in
            self?.rootController?.dismiss(animated: true)
        }
        rootController?.present(vc, animated: true)
    }

    private func navigateToMainFlow(space: SpaceDO?) {
        guard let navController = rootController else { return }
        let mainFlow = MainFlow(rootController: navController, userServices: userService, ideaService: ideaService, space: space, chatService: chatService, taskService: taskService, budgetService: budgetService, mainService: mainService)
        mainFlow.start()
        childFlow = mainFlow
    }

    private func navigateToProfile() {
        guard let vc = userProfileVC else { return }
        let viewModel = UserProfileModel(userService: userService)
        viewModel.toEditAccount = { [weak self] in
            self?.navigateToEditProfile()
        }
        viewModel.toLogin = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.logoutPressed?()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToEditProfile() {
        guard let vc = editProfileVC else { return }
        let viewModel = EditAccountModel(userService: userService)
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToJoinSingleSpace(space: SpaceDO?) {
        guard let vc = singleSpaceVC else { return }

        let viewModel = SingleSpaceViewModel(space: space, spaceService: spaceService)
        viewModel.closePressed = { [weak self] in
            self?.rootController?.dismiss(animated: false, completion: nil)
        }
        viewModel.rightEntry = { [weak self] space in
            vc.viewModel = nil
            self?.deleteVM?()
            self?.rootController?.dismiss(animated: false)
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overCurrentContext
        rootController?.present(vc, animated: false, completion: nil)
    }
}
