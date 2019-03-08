//
//  MainFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainFlow: FlowController {

    private var rootController: UINavigationController?

    init(with rootController: UINavigationController) {
        self.rootController = rootController
    }

    private lazy var mainSB: UIStoryboard? = {
        return UIStoryboard.init(name: Strings.MainSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var mainViewController: MainViewController? = {
        return self.mainSB?.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as? MainViewController
    }()
    func start() {
        guard let vc = mainViewController else {return}
        rootController?.pushViewController(vc, animated: true)
        
    }

    
}
