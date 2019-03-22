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
    var savePressed: (() -> Void)?
    private var ref: DatabaseReference?
    private var spaceName: String?
    var budgetField: BudgetField?


    init(spaceName: String?, budgetField: BudgetField?) {
        self.spaceName = spaceName
        self.budgetField = budgetField
        ref = Database.database().reference()
    }

    func savePressed(fieldName: String?, fieldSum: String?) {
        guard
            fieldName?.isEmpty != true,
            fieldSum?.isEmpty != true,
            let key = budgetField?.key
            else { return }

        let newField = BudgetField(name: fieldName!, sum: fieldSum!, key: nil)
        let childUpdates = [
            "/Spaces/\(spaceName!)/Budget/BudgetFields/\(key)" : newField.sendData()
        ]
        ref?.updateChildValues(childUpdates)
        savePressed?()
    }
}
