//
//  CreateChat.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CreateChat: UIViewController {

    @IBOutlet weak var chatName: UITextField!
    @IBOutlet weak var chatDescription: UITextView!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    var viewModel: CreateChatModel?
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
        chatDescription.delegate = self
        chatDescription.text = "Enter chat description"
        chatDescription.textColor = UIColor.placholderGrey
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
        if viewBottomConstraint.constant == 20 {
            viewBottomConstraint.constant += keyboardFrame.height + 20
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if viewBottomConstraint.constant != 20 {
            viewBottomConstraint.constant = 20
        }
    }

    @IBAction func createChatPressed(_ sender: Any) {
        viewModel?.createChat(name: chatName.text, desc: chatDescription.text)
    }
    
}

extension CreateChat: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if chatDescription.textColor == UIColor.placholderGrey {
            chatDescription.text = ""
            chatDescription.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if chatDescription.text.isEmpty {
            chatDescription.text = "Enter chat description"
            chatDescription.textColor = UIColor.placholderGrey
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = chatDescription.sizeThatFits(size)

        descriptionHeight.constant = estematedSize.height
    }
}
