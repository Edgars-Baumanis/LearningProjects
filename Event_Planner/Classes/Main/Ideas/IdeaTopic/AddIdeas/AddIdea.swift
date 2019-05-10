//
//  AddIdea.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddIdea: UIViewController {
    @IBOutlet weak var ideaName: TextFieldSubclass!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    var viewModel: AddIdeaModel?
    private var addTap: (() -> Void)?
    private var removeTap: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
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
        if viewTopConstraint.constant == 100 {
            viewTopConstraint.constant -= 50
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if viewTopConstraint.constant != 100 {
            viewTopConstraint.constant = 100
        }
    }
    
    @IBAction func addIdeaPressed(_ sender: UIButton) {
        viewModel?.addIdea(ideaName: ideaName.text)
    }
}
