//
//  JoinASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceController: UIViewController {
    
    var viewModel: JoinASpaceModel?
    @IBOutlet weak var spaceName: UITextField!
    @IBOutlet weak var spacePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    @IBAction func joinSpacePressed(_ sender: Any) {
    }
}
