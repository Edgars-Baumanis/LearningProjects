//
//  BudgetController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetController: UIViewController {
    @IBOutlet weak var Allpossitions: UITableView!
    var viewModel: BudgetModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        Allpossitions.delegate = self
        Allpossitions.dataSource = self

        let configureBudget = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(configurePressed))
        self.navigationItem.rightBarButtonItem = configureBudget
    }

    @objc func configurePressed(sender: UIBarButtonItem) {
        viewModel?.configurePressed?()
    }
}

extension BudgetController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BudgetCell.self), for: indexPath)
        if let myCell = cell as? BudgetCell {
            myCell.displayContent(name: "String", sum: 21.12)
        }
        return cell
    }
}
