//
//  GreetingVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingVC: UIViewController {
    
    var viewModel: GreetingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        viewModel?.signInPressed?()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        viewModel?.signUpPressed?()
    }
}
