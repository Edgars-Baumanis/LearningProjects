//
//  TasksController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksController: UIViewController {

    var viewModel: TasksModel?
    var tap: UITapGestureRecognizer?
    
    @IBOutlet weak var taskSearch: UISearchBar!
    @IBOutlet weak var allTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allTasks.delegate = self
        allTasks.dataSource = self
        taskSearch.delegate = self
        viewModel?.getTaskTopics()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allTasks.reloadData()
        }
        floatingButton()
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        taskSearch.showsCancelButton = false
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
        btn.addTarget(self, action: #selector(addTaskPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addTaskPressed(sender: UIBarButtonItem) {
        viewModel?.addTaskPressed?()
    }
}

extension TasksController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredDataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TasksCell.self), for: indexPath)
        if let myCell = cell as? TasksCell {
            myCell.displayContent(taskName: viewModel?.filteredDataSource?[indexPath.row].name ?? "Default Name")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed?((viewModel?.dataSource[indexPath.row])!)
    }
}

extension TasksController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filteredDataSource = searchText.isEmpty ? viewModel?.dataSource : viewModel?.dataSource.filter { (item: TaskTopic) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        allTasks.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.taskSearch.showsCancelButton = true
        view.addGestureRecognizer(tap!)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tap!)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
