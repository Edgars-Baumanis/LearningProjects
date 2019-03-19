//
//  AddBudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

struct BudgetField {
    var name: String?
    var sum: String?
    let key: String?

    init(name: String, sum: String, key: String?) {
        self.name = name
        self.sum = sum
        self.key = key
    }

    func sendData() -> Any {
        return [
            "name": name,
            "sum": sum
        ]
    }
}

class AddBudgetModel {
    private var ref: DatabaseReference?
    var emptyFields: (() -> Void)?
    var fieldAdded: (() -> Void)?
    private var spaceName: String?

    init(spaceName: String?) {
        ref = Database.database().reference()
        self.spaceName = spaceName
    }
    func addField(fieldName: String?, fieldSum: String?) {
        guard fieldName?.isEmpty != true, fieldSum?.isEmpty != true else {
            emptyFields?()
            return
        }
        let newField = BudgetField(name: fieldName!, sum: fieldSum!, key: nil)
        ref?.child("Spaces").child(spaceName!).child("BudgetFields").childByAutoId().setValue(newField.sendData())
        self.fieldAdded?()
    }
}
