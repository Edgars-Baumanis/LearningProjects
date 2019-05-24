//
//  ConfigureModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ConfigureModel {

    private var spaceKey: String?
    private let budgetService: PBudgetService?

    var savePressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?
    var budgetField: BudgetDO?

    init(spaceKey: String?, budgetField: BudgetDO?, budgetService: PBudgetService?) {
        self.budgetService = budgetService
        self.spaceKey = spaceKey
        self.budgetField = budgetField
    }

    func savePressed(fieldName: String?, fieldSum: String?) {
        budgetService?.changeField(
            spaceKey: spaceKey,
            fieldName: fieldName?.trimmingCharacters(in: .whitespacesAndNewlines),
            fieldSum: fieldSum?.trimmingCharacters(in: .whitespacesAndNewlines),
            fieldKey: budgetField?.key,
            completionHandler: { [weak self] (error) in
            if error == nil {
                self?.savePressed?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
