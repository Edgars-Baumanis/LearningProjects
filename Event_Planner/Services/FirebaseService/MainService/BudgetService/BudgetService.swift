//
//  BudgetService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import Firebase

class BudgetService: PBudgetService {

    private let ref = Database.database().reference()
    private let spaceString = "Spaces"
    private let budgetString = "Budget"
    private let budgetFieldsString = "BudgetFields"
    private let totalBudgetString = "TotalBudget"

    func getBudgetFields(spaceKey: String?, completionHandler: @escaping (BudgetDO?, String?, String?) -> Void) {
        guard spaceKey?.isEmpty != true else {
            completionHandler(nil, nil, "Empty fields for database reference")
            return
        }
        ref.child(spaceString).child(spaceKey!).child(budgetString).child(budgetFieldsString).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetDO(name: fieldName, sum: fieldSum, key: key)
            completionHandler(newField, nil, nil)
        })
        ref.child(spaceString).child(spaceKey!).child(budgetString).observe(.childAdded, with: { (snapshot) in
            guard let totalBudget = snapshot.value as? String else { return }
            completionHandler(nil, totalBudget, nil)
        })
    }

    func reloadBudgetFields(spaceKey: String?, completionHandler: @escaping (BudgetDO?, String?, String?) -> Void) {
        guard spaceKey?.isEmpty != true else {
            completionHandler(nil, nil, "Empty fields for database reference")
            return
        }
        ref.child(spaceString).child(spaceKey!).child(budgetString).child(budgetFieldsString).observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetDO(name: fieldName, sum: fieldSum, key: key)
            completionHandler(newField, nil, nil)
        })

        ref.child("Spaces").child(spaceKey!).child("Budget").observe(.childChanged, with: { (snapshot) in
            guard let changedTotalBudget = snapshot.value as? String else { return }
            completionHandler(nil, changedTotalBudget, nil)
        })
    }

    func addField(spaceKey: String?, fieldName: String?, fieldSum: String?, completionHandler: (String?) -> Void) {
        guard fieldName?.isEmpty != true, fieldSum?.isEmpty != true else {
            completionHandler("Please enter field name or field sum")
            return
        }
        guard spaceKey?.isEmpty != true else {
            completionHandler("Empty fields for database reference")
            return
        }
        let newField = BudgetDO(name: fieldName!, sum: fieldSum!, key: nil)
        ref.child(spaceString).child(spaceKey!).child(budgetString).child(budgetFieldsString).childByAutoId().setValue(newField.sendData())
        completionHandler(nil)
    }

    func addTotalSum(spaceKey: String?, totalSum: String?, completionHandler: (String?) -> Void) {

        guard totalSum?.isEmpty != true else {
            completionHandler("Please enter Total Sum")
            return
        }
        guard spaceKey?.isEmpty != true else {
            completionHandler("Empty fields for database reference")
            return
        }
        ref.child(spaceString).child(spaceKey!).child(budgetString).child(totalBudgetString).setValue(totalSum!)
        completionHandler(nil)
    }

    func changeField(spaceKey: String?, fieldName: String?, fieldSum: String?, fieldKey: String?, completionHandler: (String?) -> Void) {
        guard spaceKey?.isEmpty != true, fieldKey?.isEmpty != true else {
            completionHandler("Empty fields for database reference")
            return
        }

        guard
            fieldName?.isEmpty != true,
            fieldSum?.isEmpty != true
            else {
                completionHandler("Please enter shown fields")
                return
        }

        let newField = BudgetDO(name: fieldName!, sum: fieldSum!, key: nil)
        let childUpdates = [
            "/\(spaceString)/\(spaceKey!)/\(budgetString)/\(budgetFieldsString)/\(fieldKey!)" : newField.sendData()
        ]
        ref.updateChildValues(childUpdates)
        completionHandler(nil)
    }
}
