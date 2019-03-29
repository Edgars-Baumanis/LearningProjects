//
//  GreetingVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class GreetingVC: UIViewController {
    
    var viewModel: GreetingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
        nav?.navigationBar.tintColor = UIColor.black
        nav?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        viewModel?.signInPressed?()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        viewModel?.signUpPressed?()
    }
}
