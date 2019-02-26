//
//  GreetingVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingVC: UIViewController {
    @IBOutlet var Background: UIView!
    
    let viewModel = GreetingModel()
    override func viewDidLoad() {
        Background.setGradientBackground()
        super.viewDidLoad()
    }
    
    @IBAction func SignInPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SigninPressed"), object: nil)
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SignUpPressed"), object: nil)
    }
}
