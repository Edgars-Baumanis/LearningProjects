//
//  AddTask.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTask: UIViewController {
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var taskName: TextFieldSubclass!
    var viewModel: AddTaskModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        taskDescription.delegate = self

        taskDescription.text = "Enter task description"
        taskDescription.textColor = UIColor.placholderGrey

            viewModel?.emptyFields = { [weak self] in
                let alert = UIAlertController(title: "Empty!", message: "Please enter a name and a description for the task", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
                self?.present(alert, animated: true)
            }
    }

    @IBAction func addTaskClicked(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text, taskDescription: taskDescription.text)
    }
}


extension AddTask: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskDescription.textColor == UIColor.placholderGrey {
            taskDescription.text = ""
            taskDescription.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if taskDescription.text.isEmpty {
            taskDescription.text = "Enter task description"
            taskDescription.textColor = UIColor.placholderGrey
        }
    }
}
