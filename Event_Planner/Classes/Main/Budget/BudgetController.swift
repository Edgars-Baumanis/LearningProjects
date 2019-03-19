//
//  BudgetController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetController: UIViewController {
    @IBOutlet weak var remainingBudget: UILabel!
    @IBOutlet weak var totalBudget: UITextField!
    @IBOutlet weak var Allpossitions: UITableView!
    var viewModel: BudgetModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        Allpossitions.delegate = self
        Allpossitions.dataSource = self
        viewModel?.getData()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.Allpossitions.reloadData()
        }
        viewModel?.reloadData()
        
        let configureBudget = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addPressed))
        self.navigationItem.rightBarButtonItem = configureBudget
    }


    @objc func addPressed(sender: UIBarButtonItem) {
        viewModel?.addPressed?()
    }
}

extension BudgetController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BudgetCell.self), for: indexPath)
        if let myCell = cell as? BudgetCell {
            myCell.displayContent(
                name: viewModel?.dataSource[indexPath.row].name ?? "Default name" ,
                sum: viewModel?.dataSource[indexPath.row].sum ?? "Default Sum")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.configurePressed?(viewModel?.dataSource[indexPath.row].name, viewModel?.dataSource[indexPath.row].sum, viewModel?.dataSource[indexPath.row].key)
    }
}
