//
//  ChatsController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ChatsController: UIViewController {
    @IBOutlet weak var allChats: UITableView!
    @IBOutlet weak var searchChat: UISearchBar!

    var viewModel: ChatsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allChats.delegate = self
        allChats.dataSource = self
        viewModel?.getChats()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allChats.reloadData()
        }
        floatingButton()
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(addChatPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addChatPressed(sender: UIBarButtonItem) {
        viewModel?.addChatPressed?()
    }
}

extension ChatsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataSource.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatsCell.self), for: indexPath)
        if let myCell = cell as? ChatsCell {
            myCell.displayContent(chatName: (viewModel?.dataSource[indexPath.row])!)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellClicked?((viewModel?.dataSource[indexPath.row])!)
    }
}
