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
        fieldName.text = viewModel?.fieldName
        fieldSum.text = viewModel?.fieldSum
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        let save = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePressed))
        self.navigationItem.rightBarButtonItem = save
    }

    @objc func savePressed(sender: UIBarButtonItem) {
        viewModel?.savePressed(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }
}
