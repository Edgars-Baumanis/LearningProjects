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
    }
    @IBAction func saveBudgetPressed(_ sender: Any) {
        viewModel?.saveTotalBudget(totalBudget: totalBudget.text)
    }
}
