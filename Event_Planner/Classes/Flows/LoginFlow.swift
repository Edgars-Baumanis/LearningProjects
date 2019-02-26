//
//  LoginFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class LoginFlow: FlowController {
    let rootController = UINavigationController()
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var loginVC: LoginVC? {
        return mainSB.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    }
    
    func start() {
        guard let vc = loginVC else { return }
        self.rootController.setViewControllers([vc], animated: true)
    }
}


