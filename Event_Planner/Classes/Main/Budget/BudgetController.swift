//
//  BudgetController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetController: UIViewController {
    @IBOutlet weak var remainingBudgetView: UIView!
    @IBOutlet weak var totalBudgetView: UIView!
    @IBOutlet weak var remainingBudget: UILabel!
    @IBOutlet weak var totalBudget: UILabel!
    @IBOutlet weak var Allpossitions: UITableView!
    var viewModel: BudgetModel?
    private var buttonsShown = false
    private var editTotal: UIButton?
    private var addField: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        totalBudgetView.setCellBackground()
        remainingBudgetView.setCellBackground()
        Allpossitions.delegate = self
        Allpossitions.dataSource = self
        totalBudget.text = viewModel?.totalBudget
        remainingBudget.text = "\(viewModel?.remainingBudget ?? 0)"
        viewModel?.dataSourceChanged = { [weak self] in
            self?.Allpossitions.reloadData()
        }
        viewModel?.addTextToFields = { [weak self] in
            self?.remainingBudget.text = "\(self?.viewModel?.remainingBudget ?? 0)"
            self?.totalBudget.text = "\(self?.viewModel?.totalBudget ?? "0")"
        }
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        addField = UIButton(frame: CGRect(x: view.frame.maxX - 70, y: view.frame.maxY - view.frame.maxY / 4, width: 10, height: 10))
        editTotal = UIButton(frame: CGRect(x: view.frame.maxX - 70, y: view.frame.maxY - view.frame.maxY / 2.5, width: 10, height: 10))
        let btn = view.floatingButton()
        btn.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        guard let addField = addField, let editTotal = editTotal else { return }
        view.addSubview(addField)
        view.addSubview(editTotal)
        view.addSubview(btn)
    }

    func showButtons(_ showing: Bool) {
        buttonsShown = !showing
        if !showing {
            addField?.layer.borderWidth = 1
            addField?.layer.cornerRadius = 35
            addField?.backgroundColor = .white
            addField?.setTitle("Add", for: .normal)
             addField?.setTitleColor(.black, for: .normal)
            addField?.addTarget(self, action: #selector(addBudgetPressed), for: .touchUpInside)
            addField?.alpha = 0.7

            if viewModel?.isMainUser() == true {
                addTotalButton()
            }

            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard
                    let maxX = self?.view.frame.maxX,
                    let maxY = self?.view.frame.maxY,
                    let buttonWidth = self?.editTotal?.frame.width
                    else { return }
                self?.addField?.frame = CGRect(x: maxX - buttonWidth * 9, y: maxY - maxY / 4, width: 70, height: 70)
                if self?.viewModel?.isMainUser() == true {
                    self?.editTotal?.frame = CGRect(x: maxX - buttonWidth * 9, y: maxY - maxY / 2.5, width: 70, height: 70)
                }
            })
        } else {
            buttonsThere()
        }
    }

    private func addTotalButton() {
        editTotal?.layer.borderWidth = 1
        editTotal?.layer.cornerRadius = 35
        editTotal?.backgroundColor = .white
        editTotal?.alpha = 0.7
        editTotal?.setTitle("Total", for: .normal)
        editTotal?.setTitleColor(.black, for: .normal)
        editTotal?.addTarget(self, action: #selector(editBudgetPressed), for: .touchUpInside)
    }

    private func buttonsThere() {
        editTotal?.setTitle("", for: .normal)
        addField?.setTitle("", for: .normal)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard
                let maxX = self?.view.frame.maxX,
                let maxY = self?.view.frame.maxY
                else { return }
            self?.addField?.frame = CGRect(x: maxX + 10 , y: maxY - maxY / 4, width: 10, height: 10)
            self?.editTotal?.frame = CGRect(x: maxX + 10, y: maxY - maxY / 2.5, width: 10, height: 10)
        })
    }

    @objc func plusPressed(_ sender: UIButton) {
        showButtons(buttonsShown)
    }

    @objc func addBudgetPressed(_ sender: UIButton) {
        viewModel?.navigateToAddField?()
    }

    @objc func editBudgetPressed(_ sender: UIBarButtonItem) {
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
        viewModel?.navigateToConfigureBudget?(viewModel?.dataSource[indexPath.row])
    }
}

