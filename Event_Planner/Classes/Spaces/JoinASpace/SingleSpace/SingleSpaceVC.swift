//
//  SingleSpaceVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 07.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class SingleSpaceVC: UIViewController {

    @IBOutlet weak var spaceName: UILabel!
    @IBOutlet weak var spacePassword: UITextField!
    @IBOutlet weak var spaceDescription: UITextView!
    @IBOutlet weak var spaceDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    
    var viewModel: SingleSpaceViewModel?
    private var addTap: (() -> Void)?
    private var removeTap: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        spaceDescription.delegate = self
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
        if middleConstraint.constant == 0 {
            middleConstraint.constant -= keyboardFrame.height - 90
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if middleConstraint.constant != 0 {
            middleConstraint.constant = 0
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spaceDescription.text = viewModel?.space?.spaceDescription
        spaceName.text = viewModel?.space?.spaceName
        textViewDidChange(spaceDescription)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        viewModel?.closePressed?()
    }
    @IBAction func joinPressed(_ sender: Any) {
        viewModel?.joinASpace(password: spacePassword.text)
    }
}

extension SingleSpaceVC: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = spaceDescription.sizeThatFits(size)
        if estematedSize.height > view.bounds.height - 550 {
            spaceDescriptionHeight.constant = view.bounds.height - 550
        } else {
            spaceDescriptionHeight.constant = estematedSize.height
        }
    }
}
