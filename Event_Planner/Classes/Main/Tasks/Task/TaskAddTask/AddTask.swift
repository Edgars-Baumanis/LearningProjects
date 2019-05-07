//
//  TaskAddTask.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTask: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    var viewModel: AddTaskModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        taskDescription.delegate = self
        taskDescription.text = "Enter chat description"
        taskDescription.textColor = UIColor.placholderGrey
    }
    
    @IBAction func textDidBeginEditing(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        datePickerView.minuteInterval = 15
        datePickerView.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        datePickerView.backgroundColor = .clear
        sender.inputView = datePickerView
        sender.inputAccessoryView = UIToolbar().toolbarPicker(mySelect: #selector(dismissPicker))
    }

    @objc func dismissPicker(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @objc func datePickerChanged(_ sender: UIDatePicker) {
        deadline.text = viewModel?.dateFormatter?.string(from: sender.date)
    }

    @IBAction func saveTaskPressed(_ sender: Any) {
        viewModel?.addTask(taskName: taskName.text, taskDescription: taskDescription.text, deadline: deadline.text)
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
            taskDescription.text = "Enter chat description"
            taskDescription.textColor = UIColor.placholderGrey
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = taskDescription.sizeThatFits(size)

        descriptionHeight.constant = estematedSize.height
    }
}
