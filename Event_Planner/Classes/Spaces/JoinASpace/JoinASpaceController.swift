//
//  JoinASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceController: UIViewController {
    
    var viewModel: JoinASpaceModel?
    @IBOutlet weak var spaceName: UITextField!
    @IBOutlet weak var spacePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()

        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
    @IBAction func joinSpacePressed(_ sender: Any) {
        viewModel?.joinASpace(enteredSpaceName: spaceName.text, enteredSpacePassword: spacePassword.text)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        viewModel?.backPressed?()
    }
}
