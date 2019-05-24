//
//  ChatInfo.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 16.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatInfo: UIViewController {
    @IBOutlet weak var chatName: UITextField!
    @IBOutlet weak var chatDescription: UITextView!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!

    var editButton: UIButton?
    var viewModel: ChatInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        chatDescription.delegate = self
        configureFields()
        if viewModel?.isOwner() == true {
            addButton()
        }
        addHandlers()
        textViewDidChange(chatDescription)
    }

    private func addHandlers() {
        viewModel?.errorMessage = { [weak self] (error) in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func addButton() {
        editButton = UIButton(frame: CGRect(x: view.frame.maxX - 90, y: view.frame.maxY - 120, width: 60, height: 60))
        editButton?.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        editButton?.setImage(UIImage(named: "edit_icoc"), for: .normal)
        editButton?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        guard let editButton = editButton else { return }

        editButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        editButton.layer.cornerRadius = 30
        editButton.layer.borderWidth = 1
        view.addSubview(editButton)
    }

    @objc func editPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "save_icon"), for: .normal)
        sender.removeTarget(self, action: #selector(editPressed), for: .touchUpInside)
        sender.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        chatName.isUserInteractionEnabled = true
        chatDescription.isUserInteractionEnabled = true
    }

    @objc func savePressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "edit_icoc"), for: .normal)
        sender.removeTarget(self, action: #selector(savePressed), for: .touchUpInside)
        sender.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        chatName.isUserInteractionEnabled = false
        chatDescription.isUserInteractionEnabled = false
        viewModel?.saveData(chatName: chatName.text, chatDescription: chatDescription.text)
    }

    private func configureFields() {
        chatName.text = viewModel?.chat?.chatName
        chatDescription.text = viewModel?.chat?.chatDescription
    }
}


extension ChatInfo: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = chatDescription.sizeThatFits(size)

        descriptionHeight.constant = estematedSize.height + 50
    }
}
