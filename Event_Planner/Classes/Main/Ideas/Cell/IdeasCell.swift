//
//  IdeasCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeasCell: UITableViewCell {
    @IBOutlet weak var subjectCell: UILabel!

    func displayContent(subject: String) {
        subjectCell.text = subject
    }

}
