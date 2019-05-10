//
//  ConfigureBudget.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ConfigureBudget: UIViewController {
    @IBOutlet weak var fieldName: TextFieldSubclass!
    @IBOutlet weak var fieldSum: TextFieldSubclass!
    var viewModel: ConfigureModel?
    var addTap: (() -> Void)?
    var removeTap: (() -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        fieldName.text = viewModel?.budgetField?.name
        fieldSum.text = viewModel?.budgetField?.sum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        let save = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePressed))
        self.navigationItem.rightBarButtonItem = save
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
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
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height - self.view.frame.height / 4.5
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @objc func savePressed(sender: UIBarButtonItem) {
        viewModel?.savePressed(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }
}
