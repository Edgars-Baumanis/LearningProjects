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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        chatRoom.delegate = self
        chatRoom.dataSource = self
        self.title = viewModel?.chatName
        viewModel?.getMessages()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.chatRoom.reloadData()
        }
    }

    @IBAction func sentPressed(_ sender: Any) {
        viewModel?.sendMessage(messageText: messageField.text)
    }
}


extension ChatController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = viewModel?.currentUserID != viewModel?.dataSource[indexPath.row].userID ? String(describing: ChatCell.self) : String(describing: CurrentUserCell.self)

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        (cell as? ChatCell)?.displayContent(
            chatter: viewModel?.dataSource[indexPath.row].name ?? "Default Value",
            sentText: viewModel?.dataSource[indexPath.row].message ?? "Default Value")
        (cell as? CurrentUserCell)?.displayContent(
            user: viewModel?.dataSource[indexPath.row].name ?? "Default Value",
            message: viewModel?.dataSource[indexPath.row].message ?? "Default Value")

        return cell
    }
}
