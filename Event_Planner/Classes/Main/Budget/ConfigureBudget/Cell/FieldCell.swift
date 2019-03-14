//
//  FieldCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class FieldCell: UITableViewCell {
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var fieldSum: UILabel!
    func displayContent(name: String, sum: Double) {
        fieldName.text = name
        fieldSum.text = "\(sum)"
    }
}
