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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        chatDescription.delegate = self
        chatDescription.text = "Enter chat description"
        chatDescription.textColor = UIColor.placholderGrey
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
