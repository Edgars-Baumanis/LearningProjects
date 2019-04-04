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

        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .blackTranslucent
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
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
