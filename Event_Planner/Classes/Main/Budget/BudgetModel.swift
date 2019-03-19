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
    private var databaseHandle: DatabaseHandle?
    var configurePressed: ((_ fieldName: String?, _ fieldSum: String?, _ key: String?) -> Void)?
    var addPressed: (() -> Void)?
    var dataSource: [BudgetField] = []
    var dataSourceChanged: (() -> Void)?
    private var spaceName: String?

    init(spaceName: String?) {
        
        self.spaceName = spaceName
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
    }

    func getData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("BudgetFields").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetField(name: fieldName, sum: fieldSum, key: key)

            self.dataSource.append(newField)
            self.dataSourceChanged?()
        })
    }

    func reloadData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("BudgetFields").observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let fieldName = post?["name"] as? String,
                let fieldSum = post?["sum"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newField = BudgetField(name: fieldName, sum: fieldSum, key: key)

            var index: Int?
            self.dataSource.enumerated().forEach { (idx, value) in
                if value.key == key {
                    index = idx
                }
            }
            guard let idx = index else { return }
            self.dataSource[idx] = newField
            self.dataSourceChanged?()
        })
    }
}
