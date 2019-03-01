//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {
    
    private var appWindow: UIWindow
    var logoutPressed: (()->Void)?
    init (with window: UIWindow) {
        appWindow = window
    }
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var tabbar: MainTabbarController? = {
        let tabbar = MainTabbarController()
        return tabbar
    }()
    
    private lazy var joinVC: JoinASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: "JoinASpaceController") as? JoinASpaceController
    }()
    
    lazy var spacesVC: MySpacesVC? = {
        return mainSB.instantiateViewController(withIdentifier: "MySpacesVC") as? MySpacesVC
    }()
    
    private lazy var createVC: CreateASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: "CreateASpaceController") as? CreateASpaceController
    }()
    
    private var rootController: UITabBarController!
    
    func start() {
        guard let vc = tabbar else {return}
        rootController = vc
        guard let mySpacesVC = spacesVC else {return}
        appWindow.rootViewController = vc
        appWindow.makeKeyAndVisible()
        initiateFirstVC()
        initiateSecondVC()
        vc.viewControllers = [mySpacesVC, joinVC] as? [UIViewController]
        mySpacesVC.viewModel?.signingOut = { [weak self] in
            self?.logoutPressed?()
        }
        mySpacesVC.viewModel?.navigateToCreate = { [weak self] in
            self?.navigateToCreate()
        }
    }
    
    func initiateFirstVC() {
        guard let vc = spacesVC else {return}
        vc.viewModel = MySpacesModel()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    }
    
    
    func initiateSecondVC() {
        guard let vc = joinVC else {return}
        vc.viewModel = JoinASpaceModel()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 2)
    }
    
    func navigateToCreate() {
        guard let vc = createVC else {return}
        vc.viewModel = CreateASpaceModel()
        vc.viewModel?.backPressed = { [weak self] in
            self?.rootController.dismiss(animated: true, completion: nil)
        }
        rootController.present(vc, animated: true, completion: nil)
    }
}
