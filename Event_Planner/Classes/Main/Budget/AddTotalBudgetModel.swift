//
//  AddTotalBudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 22.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddTotalBudgetModel {
    
    private var spaceKey: String?
    private let budgetService: PBudgetService?

    var navigateToBudget: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, budgetService: PBudgetService?) {
        self.spaceKey = spaceKey
        self.budgetService = budgetService
    }

    func saveTotalBudget(totalBudget: String?) {
        budgetService?.addTotalSum(spaceKey: spaceKey, totalSum: totalBudget, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.navigateToBudget?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
