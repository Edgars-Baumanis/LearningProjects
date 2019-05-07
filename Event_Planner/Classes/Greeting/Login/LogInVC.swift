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
        loginEmail.text = Strings.hardCodedEmail.rawValue
        loginPassword.text = Strings.hardCodedPassword.rawValue
        view.setGradientBackground()
        
        viewModel?.errorMessage = { [weak self] (message) in
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }

    @IBAction func loggedIn(_ sender: Any) {
        viewModel?.loginUser(email: loginEmail.text, password: loginPassword.text)
    }
}
