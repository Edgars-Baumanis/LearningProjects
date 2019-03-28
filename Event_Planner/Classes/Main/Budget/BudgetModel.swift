//
//  BudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetModel {

    private var allFieldSum: [Float] = []
    private var spaceKey: String?
    private let budgetService: PBudgetService?
    
    var navigateToConfigureBudget: ((_ budgetField: BudgetDO?) -> Void)?
    var addTextToFields: (() -> Void)?
    var navigateToAddField: (() -> Void)?
    var totalBudget: String?
    var dataSource: [BudgetDO] = []
    var dataSourceChanged: (() -> Void)?
    var editBudgetPressed: (() -> Void)?
    var remainingBudget: Float?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, budgetService: PBudgetService?) {
        self.budgetService = budgetService
        self.spaceKey = spaceKey
        getData()
        reloadData()
    }

    func getData() {
        budgetService?.getBudgetFields(spaceKey: spaceKey, completionHandler: { [weak self] (budgetField, totalBudget, error) in
            if error == nil {
                if totalBudget == nil {
                    guard let newField = budgetField else { return }
                    self?.dataSource.append(newField)
                    self?.allFieldSum.append((newField.sum as NSString).floatValue)
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.dataSourceChanged?()
                    self?.addTextToFields?()
                } else {
                    self?.totalBudget = totalBudget
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.addTextToFields?()
                }
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func reloadData() {
        budgetService?.reloadBudgetFields(spaceKey: spaceKey, completionHandler: { [weak self] (budgetField, changedTotalBudget, error) in
            if error == nil {
                if changedTotalBudget == nil {
                    guard let newField = budgetField, let key = budgetField?.key else { return }
                    var index: Int?
                    self?.dataSource.enumerated().forEach { (idx, value) in
                        if value.key == key {
                            index = idx
                        }
                    }
                    guard let idx = index else { return }
                    self?.dataSource[idx] = newField
                    self?.allFieldSum[idx] = (newField.sum as NSString).floatValue
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.dataSourceChanged?()
                    self?.addTextToFields?()
                } else {
                    self?.totalBudget = changedTotalBudget
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.addTextToFields?()
                }
            } else {
                self?.errorMessage?(error)
            }
        }) 
    }

    private func calculateRemaining() -> Float {
        guard let totalBudget = (self.totalBudget as NSString?)?.floatValue else { return 0 }
        return totalBudget - allFieldSum.reduce(0, +)
    }
}
