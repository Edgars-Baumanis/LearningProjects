//
//  AddTotalBudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 22.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddTotalBudgetModel {
    private var spaceName: String?
    private var ref: DatabaseReference?
    var addPressed: (() -> Void)?

    init(spaceName: String?) {
        self.spaceName = spaceName
        ref = Database.database().reference()
    }

    func saveTotalBudget(totalBudget: String?) {
        guard totalBudget?.isEmpty != true else { return }
        ref?.child("Spaces").child(spaceName!).child("Budget").child("TotalBudget").setValue(totalBudget!)
        self.addPressed?()
    }
}
