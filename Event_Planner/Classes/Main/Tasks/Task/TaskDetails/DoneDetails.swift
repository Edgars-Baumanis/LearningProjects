//
//  DoneDetails.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class DoneDetails: UIViewController {
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var taskOwner: UILabel!
    @IBOutlet weak var timeAdded: UILabel!
    var viewModel: DoneDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewContent.setGradientBackground()
        taskName.text = viewModel?.task?.name
        taskDescription.text = viewModel?.task?.description

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
    }
    @IBAction func deletePressed(_ sender: Any) {
        viewModel?.deleteTask()
    }
}
