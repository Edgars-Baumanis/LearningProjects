//
//  TopicCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 07.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
        cellBackground.setCellBackground()
    }

    func displayContent(labelText: String?) {
        cellLabel.text = labelText
    }
}
