//
//  OtherCells.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 05.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class OtherCells: UITableViewCell {
    @IBOutlet weak var otherSpacesView: UIView!
    @IBOutlet weak var otherSpaceName: UILabel!

    func  displayContent(name: String?) {
        otherSpacesView.setCellBackground()
        otherSpaceName.text = name
    }
}
