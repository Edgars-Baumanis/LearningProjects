//
//  LoginVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    @IBAction func LoggedIn(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("LoggedIn"), object: nil)
    }
    
}
