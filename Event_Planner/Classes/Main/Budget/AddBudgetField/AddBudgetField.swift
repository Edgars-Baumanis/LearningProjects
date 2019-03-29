//
//  AddBudgetField.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddBudgetField: UIViewController {
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var fieldSum: UITextField!

    var viewModel: AddBudgetModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
    }
    @IBAction func addFieldPressed(_ sender: Any) {
        viewModel?.addField(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }
}
