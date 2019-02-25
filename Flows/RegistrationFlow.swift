//
//  RegistrationFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class RegistrationFlow: FlowController {
    let rootController = UINavigationController()
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var registerVC: SignUpVC? {
        return mainSB.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
    }
    
    func start() {
        guard let vc = registerVC else { return }
        self.rootController.setViewControllers([vc], animated: true)
    }
}
