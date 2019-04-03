//
//  TaskDetails.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskDetails: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeightConstraint: NSLayoutConstraint!
    var viewModel: TaskDetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        taskDescription.delegate = self
        taskName.text = viewModel?.task?.name
        owner.text = viewModel?.task?.ownerID
        deadline.text = viewModel?.task?.deadline
        taskDescription.text = viewModel?.task?.description
        textViewDidChange(taskDescription)
    }
    @IBAction func progressPressed(_ sender: UIButton) {
    }
    @IBAction func deletePressed(_ sender: UIButton) {
    }
}


extension TaskDetails: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = taskDescription.sizeThatFits(size)

        descriptionHeightConstraint.constant = estematedSize.height
        descriptionViewHeight.constant = estematedSize.height + 50
    }
}
