//
//  AddBudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddBudgetModel {

    private var spaceKey: String?
    private var ref: DatabaseReference?
    
    var emptyFields: (() -> Void)?
    var fieldAdded: (() -> Void)?

    init(spaceKey: String?) {
        ref = Database.database().reference()
        self.spaceKey = spaceKey
    }
    func addField(fieldName: String?, fieldSum: String?) {
        guard fieldName?.isEmpty != true, fieldSum?.isEmpty != true else {
            emptyFields?()
            return
        }
        let newField = BudgetField(name: fieldName!, sum: fieldSum!, key: nil)
        ref?.child("Spaces").child(spaceKey!).child("Budget").child("BudgetFields").childByAutoId().setValue(newField.sendData())
        self.fieldAdded?()
    }
}
