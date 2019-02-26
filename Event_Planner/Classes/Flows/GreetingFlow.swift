//
//  GreetingFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingFlow: FlowController {
    let rootController = UINavigationController()
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var greetingViewController: GreetingVC? {
        return mainSB.instantiateViewController(withIdentifier: "GreetingVC") as? GreetingVC
    }
    
    func start() {
        guard let vc = greetingViewController else { fatalError() }
        self.rootController.setViewControllers([vc], animated: true)
    }
}
