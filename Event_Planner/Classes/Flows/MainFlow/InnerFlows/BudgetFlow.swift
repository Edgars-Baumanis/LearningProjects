//
//  BudgetFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetFlow: FlowController {

    private var rootController: UINavigationController?
    private var space: SpaceDO?
    private var budgetField: BudgetDO?
    private var budgetService: PBudgetService?
    private var userService: PUserService?
    

    init(rootController: UINavigationController?, space: SpaceDO?, budgetService: PBudgetService?, userService: PUserService?) {
        self.budgetService = budgetService
        self.rootController = rootController
        self.space = space
        self.userService = userService
    }

    private lazy var budgetSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.BudgetSB.rawValue, bundle: Bundle.main)
    }()

    private var budgetViewController: BudgetViewController? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: BudgetViewController.self)) as? BudgetViewController
    }

    private var configureBudget: ConfigureBudget? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: ConfigureBudget.self)) as? ConfigureBudget
    }

    private var addBudgetFieldController: AddBudgetField? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: AddBudgetField.self)) as? AddBudgetField
    }

    private var addTotalBudgetController: AddTotalBudget? {
        return budgetSB.instantiateViewController(withIdentifier: String(describing: AddTotalBudget.self)) as? AddTotalBudget
    }

    func start() {
        navigateToBudget()
    }

    private func navigateToBudget() {
        guard let vc = budgetViewController else { return }
        let viewModel = BudgetModel(spaceKey: space?.key, budgetService: budgetService, userService, space)
        viewModel.navigateToConfigureBudget = { [weak self] budgetField in
            self?.budgetField = budgetField
            self?.navigateToConfigureBudget()
        }
        viewModel.navigateToAddField = { [weak self] in
            self?.navigateToAddBudgetField()
        }
        viewModel.editBudgetPressed = { [weak self] in
            self?.navigateToAddTotalBudget()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToConfigureBudget() {
        guard let vc = configureBudget else { return }
        let viewModel = ConfigureModel(spaceKey: space?.key, budgetField: budgetField, budgetService: budgetService)

        viewModel.savePressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddBudgetField() {
        guard let vc = addBudgetFieldController else { return }
        let viewModel = AddBudgetModel(spaceKey: space?.key, budgetService: budgetService)
        viewModel.fieldAdded = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddTotalBudget() {
        guard let vc = addTotalBudgetController else { return }
        let viewModel = AddTotalBudgetModel(spaceKey: space?.key, budgetService: budgetService)
        viewModel.navigateToBudget = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

}
