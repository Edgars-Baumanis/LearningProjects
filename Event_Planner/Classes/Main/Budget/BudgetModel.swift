//
//  BudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class BudgetModel {

    private var ref: DatabaseReference?
    private var allFieldSum: [Float] = []
    private var spaceKey: String?
    
    var navigateToConfigureBudget: ((_ budgetField: BudgetDO?) -> Void)?
    var addTextToFields: (() -> Void)?
    var navigateToAddField: (() -> Void)?
    var totalBudget: String?
    var dataSource: [BudgetDO] = []
    var dataSourceChanged: (() -> Void)?
    var editBudgetPressed: (() -> Void)?
    var remainingBudget: Float?

    init(spaceKey: String?) {
        self.spaceKey = spaceKey
        ref = Database.database().reference()
    }

    func getData() {
        ref?.child("Spaces").child(spaceKey!).child("Budget").child("BudgetFields").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetDO(name: fieldName, sum: fieldSum, key: key)

            self.dataSource.append(newField)
            self.allFieldSum.append((newField.sum as NSString).floatValue)
            self.remainingBudget = self.calculateRemaining()
            self.dataSourceChanged?()
            self.addTextToFields?()
        })
        ref?.child("Spaces").child(spaceKey!).child("Budget").observe(.childAdded, with: { (snapshot) in
            guard let totalBudget = snapshot.value as? String else { return }
            self.totalBudget = totalBudget
            self.remainingBudget = self.calculateRemaining()
            self.addTextToFields?()
        })
    }

    func reloadData() {
        ref?.child("Spaces").child(spaceKey!).child("Budget").child("BudgetFields").observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetDO(name: fieldName, sum: fieldSum, key: key)

            var index: Int?
            self.dataSource.enumerated().forEach { (idx, value) in
                if value.key == key {
                    index = idx
                }
            }
            guard let idx = index else { return }
            self.dataSource[idx] = newField
            self.allFieldSum[idx] = (newField.sum as NSString).floatValue
            self.remainingBudget = self.calculateRemaining()
            self.dataSourceChanged?()
            self.addTextToFields?()
        })
        ref?.child("Spaces").child(spaceKey!).child("Budget").observe(.childChanged, with: { (snapshot) in
            guard let changedTotalBudget = snapshot.value as? String else { return }
            self.totalBudget = changedTotalBudget
            self.remainingBudget = self.calculateRemaining()
            self.addTextToFields?()
        })
    }

    private func calculateRemaining() -> Float {
        guard let totalBudget = (self.totalBudget as NSString?)?.floatValue else { return 0 }
        return totalBudget - allFieldSum.reduce(0, +)
    }
}
