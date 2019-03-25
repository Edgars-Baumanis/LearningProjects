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
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var deadline: UIDatePicker!
    var viewModel: TaskAddTaskModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        taskDescription.delegate = self
        taskDescription.text = "Enter chat description"
        taskDescription.textColor = UIColor.placholderGrey
    }

    @IBAction func addTaskPressed(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text, taskDescription: taskDescription.text, deadline: viewModel?.dateFormatter?.string(from: deadline.date))
    }
    @IBAction func currentDayPressed(_ sender: Any) {
        deadline.setDate(Date(), animated: true)
    }
}


extension TaskAddTask: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskDescription.textColor == UIColor.placholderGrey {
            taskDescription.text = ""
            taskDescription.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if taskDescription.text.isEmpty {
            taskDescription.text = "Enter chat description"
            taskDescription.textColor = UIColor.placholderGrey
        }
    }
}
