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
        title = viewModel?.space?.spaceName
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = backButton

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
        nav?.navigationBar.tintColor = UIColor.black
        nav?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }

    @IBAction func chatPressed(_ sender: UIButton) {
        viewModel?.chatPressed?()
    }

    @IBAction func budgetPressed(_ sender: UIButton) {
        viewModel?.budgetPressed?()
    }

    @IBAction func tasksPressed(_ sender: UIButton) {
        viewModel?.tasksPressed?()
    }

    @IBAction func ideasPressed(_ sender: UIButton) {
        viewModel?.ideasPressed?()
    }

    @objc func backPressed(sender: UIBarButtonItem) {
        viewModel?.backPressed?()
    }
}
