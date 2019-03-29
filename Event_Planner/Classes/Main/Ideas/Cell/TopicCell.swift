//
//  TopicCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    @IBOutlet weak var subjectCell: UILabel!
    @IBOutlet weak var topicView: UIView!

    func displayContent(subject: String?) {
        topicView.createGradient()
        subjectCell.text = subject
    }
}
