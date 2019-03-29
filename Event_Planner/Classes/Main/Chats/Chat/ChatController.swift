//
//  ChatController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    @IBOutlet weak var chatRoom: UITableView!
    @IBOutlet weak var messageField: UITextField!
    var viewModel: ChatModel?
    var addTap: (() -> Void)?
    var removeTap: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        chatRoom.delegate = self
        chatRoom.dataSource = self
        self.title = viewModel?.chat?.chatName
        viewModel?.dataSourceChanged = { [weak self] in
            self?.chatRoom.reloadData()
            self?.scrollToBottom()
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


        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        removeTap?()
    }

    @IBAction func sentPressed(_ sender: Any) {
        viewModel?.sendMessage(messageText: messageField.text)
        messageField.text = nil
    }
}

extension ChatController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = viewModel?.currentUserID != viewModel?.dataSource[indexPath.row].userID ? String(describing: ChatCell.self) : String(describing: CurrentUserCell.self)

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            (cell as? ChatCell)?.displayContent(message: self?.viewModel?.dataSource[indexPath.row])
            (cell as? CurrentUserCell)?.displayContent(message: self?.viewModel?.dataSource[indexPath.row])
        })

        return cell
    }

    func scrollToBottom() {
        if viewModel?.dataSource.count != 0 {
            let indexPath = IndexPath(row: (self.viewModel?.dataSource.count ?? 0) - 1, section: 0)
            self.chatRoom.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
