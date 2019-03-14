//
//  BudgetCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    @IBOutlet weak var budgetCell: UILabel!
    func displayContent(name: String, sum: Double) {
        budgetCell.text = "\(name): \(sum)"
    }
}
