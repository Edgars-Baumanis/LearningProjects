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
    
    var viewModel: LoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmail.text = "123@123.com"
        loginPassword.text = "123123"
        view.setGradientBackground()
    }
    
    @IBAction func loggedIn(_ sender: Any) {
        viewModel?.loginUser(email: loginEmail.text, password: loginPassword.text)
        viewModel?.wrongSignIn = { [weak self] in
            let alert = UIAlertController(title: "Wrong Credentials", message: "Please enter correct ones", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
}
