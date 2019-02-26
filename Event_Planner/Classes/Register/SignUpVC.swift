//
//  SignUpVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    @IBOutlet weak var regScreenName: UITextField!
    @IBOutlet weak var regEmail: UITextField!
    @IBOutlet weak var regPassword: UITextField!
    
    let viewModel = SignUpModel()
    override func viewDidLoad() {
        view.setGradientBackground()
        super.viewDidLoad()

    }
    @IBAction func signedUp(_ sender: Any) {
        guard
            let email = regEmail.text,
            let password = regPassword.text
            else { return }
        if email.isEmpty || password.isEmpty {
            print("Please enter password and email")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error)
                } else {
                    NotificationCenter.default.post(name: Notification.Name("SigninPressed"), object: nil)
                }
            }
        }
    }
}
