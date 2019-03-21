//
//  InProgressDetails.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class InProgressDetails: UIViewController {
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var taskOwner: UILabel!
    @IBOutlet weak var timeAdded: UILabel!
    var viewModel: InProgressDetailsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        scrollViewContent.setGradientBackground()
        taskName.text = viewModel?.task?.name
        taskDescription.text = viewModel?.task?.description
    }
    @IBAction func donePressed(_ sender: Any) {
        viewModel?.taskDone()
    }
}
