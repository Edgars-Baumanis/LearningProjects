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
        floatingButton()
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = UIColor.black
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(budgetEntered), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func budgetEntered(sender: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in

        })
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

