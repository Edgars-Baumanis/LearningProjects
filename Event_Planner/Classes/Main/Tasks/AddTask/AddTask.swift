//
//  AddTask.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTask: UIViewController, UITextViewDelegate {
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var taskName: TextFieldSubclass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        taskDescription.delegate = self

        taskDescription.text = "Enter task description"
        taskDescription.textColor = UIColor.placholderGrey
    }

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