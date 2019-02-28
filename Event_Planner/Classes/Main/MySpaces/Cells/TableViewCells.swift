//
//  TableViewCells.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MySpacesCell: UITableViewCell {
    @IBOutlet weak var MySpacesContent: UILabel!
    
    func displayContent(spaceName: String) {
        MySpacesContent.text = spaceName
    }
    
}
