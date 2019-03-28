//
//  AddTotalBudget.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 22.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTotalBudget: UIViewController {
    @IBOutlet weak var totalBudget: UITextField!
    var viewModel: AddTotalBudgetModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    @IBAction func saveBudgetPressed(_ sender: Any) {
        viewModel?.saveTotalBudget(totalBudget: totalBudget.text)
    }
}
