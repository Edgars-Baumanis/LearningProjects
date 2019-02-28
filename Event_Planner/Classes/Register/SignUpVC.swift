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
    
    var viewModel: SignUpModel?
    override func viewDidLoad() {
        view.setGradientBackground()
        super.viewDidLoad()

    }
    
    @IBAction func signedUpPressed(_ sender: Any) {
        viewModel?.signUpUser(email: regEmail.text, password: regPassword.text)
    }
}
