//
//  AddTopicController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTopicController: UIViewController {

    @IBOutlet weak var topicName: TextFieldSubclass!
    var viewModel: AddTopicModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    @IBAction func addTopicPressed(_ sender: Any) {
        viewModel?.addTopic(topicName: topicName.text)
    }
}
