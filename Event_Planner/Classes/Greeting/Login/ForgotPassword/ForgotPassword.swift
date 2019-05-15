//
//  ForgotPassword.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {
    @IBOutlet var backGroundView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var viewModel: ForgorPasswordModel?
    var addTap: (() -> Void)?
    var removeTap: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addTap = { [weak self] in
            self?.view.addGestureRecognizer(keyboardTap)
        }
        removeTap = { [weak self] in
            self?.view.removeGestureRecognizer(keyboardTap)
        }

        viewModel?.errorMessage = { [weak self] (title, message) in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                if title == "Success" {
                    self?.viewModel?.closePressed?()
                } else { return }
            }))
            self?.present(alert, animated: true)
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
        if heightConstraint.constant == 0 {
            heightConstraint.constant -= keyboardFrame.height - 130
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if heightConstraint.constant != 0 {
            heightConstraint.constant = 0
        }
    }

    @objc func dismissVC(_ sender: UITapGestureRecognizer) {
        viewModel?.closePressed?()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        viewModel?.sendPasswordReset(email.text)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        viewModel?.closePressed?()
    }
}
