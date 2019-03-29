//
//  CreateChat.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class CreateChat: UIViewController {
    @IBOutlet weak var chatName: TextFieldSubclass!
    @IBOutlet weak var chatPassword: TextFieldSubclass!
    @IBOutlet weak var chatDescription: TextViewSubclass!
    var viewModel: CreateChatModel?
    
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

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
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
}
