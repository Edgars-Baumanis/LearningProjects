//
//  TaskInProgress.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskInProgress: UIViewController {
    @IBOutlet weak var tasksInProgress: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        tasksInProgress.delegate = self
        tasksInProgress.dataSource = self

    }
}

extension TaskInProgress: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskInProgressCell.self), for: indexPath)
        if let myCell = cell as? TaskInProgressCell {
            myCell.displayContent(name: "InProgress")
        }
        return cell
    }
}

