//
//  MainViewController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    @IBAction func chatPressed(_ sender: Any) {
        viewModel?.chatPressed?()
    }
    @IBAction func budgetPressed(_ sender: Any) {
        viewModel?.budgetPressed?()
    }
    @IBAction func tasksPressed(_ sender: Any) {
        viewModel?.tasksPressed?()
    }
    @IBAction func ideasPressed(_ sender: Any) {
        viewModel?.ideasPressed?()
    }
}
