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
    }
    @IBAction func addFieldPressed(_ sender: Any) {
        viewModel?.addField(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }
}
