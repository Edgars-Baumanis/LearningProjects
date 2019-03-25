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
    var tap: UITapGestureRecognizer?
    var viewModel: ChatsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allChats.delegate = self
        allChats.dataSource = self
        searchChat.delegate = self
        viewModel?.getChats()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allChats.reloadData()
        }
        floatingButton()
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        searchChat.showsCancelButton = false
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
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
        return viewModel?.filteredDataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatsCell.self), for: indexPath)
        if let myCell = cell as? ChatsCell {
            myCell.displayContent(chatName: viewModel?.filteredDataSource?[indexPath.row].chatName ?? "Default Value")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellClicked?(viewModel?.dataSource[indexPath.row])
    }
}

extension ChatsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filteredDataSource = searchText.isEmpty ? viewModel?.dataSource : viewModel?.dataSource.filter { (item: Chat) -> Bool in
            return item.chatName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        allChats.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        view.addGestureRecognizer(tap!)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tap!)
        searchBar.resignFirstResponder()
    }
}

