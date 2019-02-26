//
//  LoginVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    @IBAction func LoggedIn(_ sender: Any) {
        guard
            let email = loginEmail.text,
            let password = loginPassword.text
        else { return }
        if email.isEmpty && password.isEmpty { return }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error)
                } else {
                    NotificationCenter.default.post(name: Notification.Name("LoggedIn"), object: nil)
                }
            }
        }
    }
}
