//
//  SpacesFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SpacesFlow: FlowController {
    let rootController = UINavigationController()
    
    private lazy var mainSB: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    private var spacesVC: MySpacesVC? {
        return mainSB.instantiateViewController(withIdentifier: "SpacesVC") as? MySpacesVC
    }
    
    func start() {
        guard let vc = spacesVC else { return }
        self.rootController.setViewControllers([vc], animated: true)
    }
}
