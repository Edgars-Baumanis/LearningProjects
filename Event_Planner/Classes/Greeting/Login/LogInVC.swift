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
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: LoginModel?
    var addTap: (() -> Void)?
    var removeTap: (() -> Void)?

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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addTap = { [weak self] in
            self?.view.addGestureRecognizer(tap)
        }
        removeTap = { [weak self] in
            self?.view.removeGestureRecognizer(tap)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        removeTap?()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if bottomConstraint.constant == 40 {
            bottomConstraint.constant += keyboardFrame.height - 20
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if bottomConstraint.constant != 40 {
            bottomConstraint.constant = 40
        }
    }

    @IBAction func loggedIn(_ sender: Any) {
        viewModel?.loginUser(email: loginEmail.text, password: loginPassword.text)
    }
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        viewModel?.forgotPassword?()
    }
}
