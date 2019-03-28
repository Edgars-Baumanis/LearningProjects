//
//  AddTaskTopic.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTaskTopic: UIViewController {
    @IBOutlet weak var taskName: TextFieldSubclass!
    var viewModel: AddTaskTopicModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewModel?.emptyFields = { [weak self] in
            let alert = UIAlertController(title: "Empty!", message: "Please enter a name and a description for the task", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }

    @IBAction func addTaskClicked(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text)
    }
}