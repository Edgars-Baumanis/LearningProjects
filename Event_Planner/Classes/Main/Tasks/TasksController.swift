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
    @IBOutlet weak var taskSearch: UISearchBar!
    @IBOutlet weak var allTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allTasks.delegate = self
        allTasks.dataSource = self
        viewModel?.getTaskTopics()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allTasks.reloadData()
        }
        let addTask = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTaskPressed))
        self.navigationItem.rightBarButtonItem = addTask
    }

    @objc func addTaskPressed(sender: UIBarButtonItem) {
        viewModel?.addTaskPressed?()
    }
}

extension TasksController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TasksCell.self), for: indexPath)
        if let myCell = cell as? TasksCell {
            myCell.displayContent(taskName: (viewModel?.dataSource[indexPath.row])!)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed?()
    }
}
