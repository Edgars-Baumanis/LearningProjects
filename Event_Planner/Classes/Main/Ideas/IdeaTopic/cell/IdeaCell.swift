//
//  IdeaCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeaCell: UITableViewCell {
    @IBOutlet weak var ideaName: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    func displayContent(name: String, count: Int) {
        ideaName.text = name + ": "
        likeCount.text = "\(count)"
    }
}
