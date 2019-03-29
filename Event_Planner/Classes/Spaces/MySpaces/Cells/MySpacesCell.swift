//
//  MySpacesCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 05.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MySpacesCell: UITableViewCell {
    @IBOutlet weak var mySpacesContent: UILabel!
    @IBOutlet weak var mySpacesContentView: UIView!

    func displayContent(spaceName: String?) {
        mySpacesContentView.createGradient()
        guard spaceName?.isEmpty != true else { return }
        mySpacesContent.text = spaceName
    }
}
