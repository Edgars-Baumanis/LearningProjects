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
    @IBOutlet weak var totalBudget: UILabel!
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
        viewModel?.addTextToFields = { [weak self] in
            self?.remainingBudget.text = "\(self?.viewModel?.remainingBudget ?? 0)"
            self?.totalBudget.text = "\(self?.viewModel?.totalBudget ?? "0")"
        }
        viewModel?.reloadData()
        floatingButton()
        navigationBarItem()

    }

    func navigationBarItem() {
        let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBudgetPressed))
        navigationItem.rightBarButtonItem = btn
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(addBudgetPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addBudgetPressed(sender: UIButton) {
        viewModel?.addPressed?()
    }

    @objc func editBudgetPressed(sender: UIBarButtonItem) {
        viewModel?.editBudgetPressed?()
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
        viewModel?.configurePressed?(viewModel?.dataSource[indexPath.row])
    }
}

