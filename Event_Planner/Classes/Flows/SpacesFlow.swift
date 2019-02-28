//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {

    private var rootController: UIViewController?
    private var appWindow: UIWindow
    init (with window: UIWindow) {
        appWindow = window
    }
    
    // Create constant, better if enum "Main"
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var tabbar: MainTabbarController? = {
        let tabbar = MainTabbarController()
        return tabbar
    }()
    
    func start() {
        guard let vc = tabbar else { return }
        appWindow.rootViewController = vc
        appWindow.makeKeyAndVisible()
        initiateFirst()
        initiateSecond()
        initiateThird()
        vc.viewControllers = [mainVC, createVC, joinVC] as? [UIViewController]
    }

    func initiateFirst() {
        guard let vc = mainVC else {return}
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    }
    
    func initiateSecond() {
        guard let vc = createVC else {return}
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
    }
    
    func initiateThird() {
        guard let vc = joinVC else {return}
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 2)
    }
    
    private lazy var joinVC: JoinASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: "JoinASpaceController") as? JoinASpaceController
    }()
    
    lazy var mainVC: MySpacesVC? = {
        return mainSB.instantiateViewController(withIdentifier: "MySpacesVC") as? MySpacesVC
    }()
    
    private lazy var createVC: CreateASpaceController? = {
        return mainSB.instantiateViewController(withIdentifier: "CreateASpaceController") as? CreateASpaceController
    }()
}


