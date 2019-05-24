//
//  AddBudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddBudgetModel {

    private var spaceKey: String?
    private let budgetService: PBudgetService?
    
    var errorMessage: ((String?) -> Void)?
    var fieldAdded: (() -> Void)?

    init(spaceKey: String?, budgetService: PBudgetService?) {
        self.spaceKey = spaceKey
        self.budgetService = budgetService
    }
    func addField(fieldName: String?, fieldSum: String?) {
        budgetService?.addField(
            spaceKey: spaceKey,
            fieldName: fieldName?.trimmingCharacters(in: .whitespacesAndNewlines),
            fieldSum: fieldSum?.trimmingCharacters(in: .whitespacesAndNewlines),
            completionHandler: { [weak self] (error) in
            if error == nil {
                self?.fieldAdded?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
