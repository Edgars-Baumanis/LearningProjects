//
//  TasksController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksController: UIViewController {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCells.self), for: indexPath)
        if let myCell = cell as? TaskCells {
            myCell.displayContent(taskName: "kakakaka")
        }
        return cell
    }

    
}
