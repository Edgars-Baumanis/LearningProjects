//
//  ConfigureBudget.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ConfigureBudget: UIViewController {
    @IBOutlet weak var fieldName: TextFieldSubclass!
    @IBOutlet weak var fieldSum: TextFieldSubclass!
    var viewModel: ConfigureModel?

    override func viewWillAppear(_ animated: Bool) {
        fieldName.text = viewModel?.budgetField?.name
        fieldSum.text = viewModel?.budgetField?.sum
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        let save = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePressed))
        self.navigationItem.rightBarButtonItem = save
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }

    @objc func savePressed(sender: UIBarButtonItem) {
        viewModel?.savePressed(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }
}
