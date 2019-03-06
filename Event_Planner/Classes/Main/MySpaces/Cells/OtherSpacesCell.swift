//
//  TableViewCells.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit



class OtherSpacesCell: UITableViewCell {
    @IBOutlet weak var OtherSpacesContent: UILabel!
    
    func displayContent(spaceName: String) {
        OtherSpacesContent.text = spaceName
    }
}
