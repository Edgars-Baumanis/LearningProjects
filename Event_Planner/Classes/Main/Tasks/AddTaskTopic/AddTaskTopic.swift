//
//  AddTaskTopic.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTaskTopic: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var viewTopConstrint: NSLayoutConstraint!
    
    var viewModel: AddTaskTopicModel?
    private var addTap: (() -> Void)?
    private var removeTap: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
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
        if viewTopConstrint.constant == 100 {
            viewTopConstrint.constant -= keyboardFrame.height - view.frame.height / 3
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if viewTopConstrint.constant != 100 {
            viewTopConstrint.constant = 100
        }
    }

    @IBAction func addTaskClicked(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text)
    }
}
