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
    var fieldName: String?
    var fieldSum: String?
    var savePressed: (() -> Void)?
    private var ref: DatabaseReference?
    private var spaceName: String?
    private var fieldKey: String?


    init(fieldName: String?, fieldSum: String?, spaceName: String?, fieldKey: String?) {
        self.fieldKey = fieldKey
        self.spaceName = spaceName
        self.fieldName = fieldName
        self.fieldSum = fieldSum
        ref = Database.database().reference()
    }

    func savePressed(fieldName: String?, fieldSum: String?) {
        guard fieldName?.isEmpty != true, fieldSum?.isEmpty != true else { return }
        guard let key = fieldKey else { return }
        let newField = BudgetField(name: fieldName!, sum: fieldSum!, key: nil)
        let childUpdates = [
            "/Spaces/\(spaceName!)/BudgetFields/\(key)" : newField.sendData()
        ]
        ref?.updateChildValues(childUpdates)
        savePressed?()
    }
}
