//
//  CreateASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase


class CreateASpaceController: UIViewController {
    @IBOutlet weak var spaceName: UITextField!
    @IBOutlet weak var spacePassword: UITextField!
    @IBOutlet weak var spaceDescription: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    var viewModel: CreateASpaceModel?
    private var addTap: (() -> Void)?
    private var removeTap: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        spaceDescription.delegate = self
        spaceDescription.text = "Enter a description for your Space"
        spaceDescription.textColor = UIColor.placholderGrey
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Empty!", message: message, preferredStyle: .alert)
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
        if bottomConstraint.constant == 20 {
            bottomConstraint.constant += keyboardFrame.height
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if bottomConstraint.constant != 20 {
            bottomConstraint.constant = 20
        }
    }
    
    @IBAction func createSpace(_ sender: UIButton) {
        viewModel?.createASpace(name: spaceName.text, password: spacePassword.text, description: spaceDescription.text)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        viewModel?.backPressed?()
    }
}

extension CreateASpaceController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if spaceDescription.textColor == UIColor.placholderGrey {
            spaceDescription.text = nil
            spaceDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if spaceDescription.text.isEmpty {
            spaceDescription.text = "Enter a description for your Space"
            spaceDescription.textColor = UIColor.placholderGrey
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = spaceDescription.sizeThatFits(size)

        descriptionHeight.constant = estematedSize.height + 10
    }
}
