//
//  TaskDone.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskDone: UIViewController {
    @IBOutlet weak var tasksDone: UITableView!
    var viewModel: TaskDoneModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        tasksDone.delegate = self
        tasksDone.dataSource = self
        viewModel?.getData()
        viewModel?.dataDeleted()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.tasksDone.reloadData()
        }
    }
}

extension TaskDone: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskDoneCell.self), for: indexPath)
        if let myCell = cell as? TaskDoneCell {
            myCell.displayContent(name: viewModel?.dataSource[indexPath.row].name ?? "Default Value")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToDetails?(viewModel?.dataSource[indexPath.row])
    }
}

