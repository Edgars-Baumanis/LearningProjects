//
//  TasksController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksController: UIViewController {

    @IBOutlet weak var taskSearch: UISearchBar!
    @IBOutlet weak var allTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
}

extension TasksController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.TasksSB.rawValue , for: indexPath)
        if let myCell = cell as? TasksCell {
            myCell.displayContent(taskName: String(describing: TasksCell.self))
        }
        return cell
    }
}
