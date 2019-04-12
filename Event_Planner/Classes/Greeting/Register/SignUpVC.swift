//
//  SignUpVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var regScreenName: UITextField!
    @IBOutlet weak var regEmail: UITextField!
    @IBOutlet weak var regPassword: UITextField!
    
    var viewModel: SignUpModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()

        viewModel?.emptyFields = { [weak self] in
            let alert = UIAlertController(title: "Empty!", message: "Please enter username email and/or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }

        viewModel?.existingEmail = { [weak self] in
            let alert = UIAlertController(title: "Existing/Incorrect", message: "Please enter correct ones", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
    @IBAction func signedUpPressed(_ sender: Any) {
        viewModel?.signUpUser(email: regEmail.text, password: regPassword.text, userName: regScreenName.text)
    }
}
