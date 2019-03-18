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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatCell.self), for: indexPath)
        if let myCell = cell as? ChatCell {
            myCell.displayContent(chatter: (viewModel?.dataSource[indexPath.row].name)!, sentText: (viewModel?.dataSource[indexPath.row].message)!)
        }
        return cell
    }
}
