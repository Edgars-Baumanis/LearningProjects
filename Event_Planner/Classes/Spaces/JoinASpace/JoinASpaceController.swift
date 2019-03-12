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
    }
    
    @IBAction func joinSpacePressed(_ sender: Any) {
        
        viewModel?.joinASpace(spaceName: spaceName.text, spacePassword: spacePassword.text)
        viewModel?.emptyFields = { [weak self] in
            let alert = UIAlertController(title: "Empty!", message: "Please enter data in fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
}
