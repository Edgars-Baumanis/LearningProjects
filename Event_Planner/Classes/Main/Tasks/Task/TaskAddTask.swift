//
//  TaskAddTask.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskAddTask: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: TextViewSubclass!
    var viewModel: TaskAddTaskModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addTaskPressed(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text, taskDescription: taskDescription.text)
    }
}
