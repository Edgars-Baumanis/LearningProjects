//
//  ConfigureModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class ConfigureModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?

    var savePressed: (() -> Void)?
    var budgetField: BudgetDO?

    init(spaceKey: String?, budgetField: BudgetDO?) {
        self.spaceKey = spaceKey
        self.budgetField = budgetField
        ref = Database.database().reference()
    }

    func savePressed(fieldName: String?, fieldSum: String?) {
        guard
            fieldName?.isEmpty != true,
            fieldSum?.isEmpty != true,
            let key = budgetField?.key
            else { return }

        let newField = BudgetDO(name: fieldName!, sum: fieldSum!, key: nil)
        let childUpdates = [
            "/Spaces/\(spaceKey!)/Budget/BudgetFields/\(key)" : newField.sendData()
        ]
        ref?.updateChildValues(childUpdates)
        savePressed?()
    }
}
