//
//  IdeaCell.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeaCell: UITableViewCell {
    @IBOutlet weak var ideaView: UIView!
    @IBOutlet weak var ideaName: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    func displayContent(name: String?, count: Int?, isLiked: Bool?) {
        guard
            let name = name,
            let count = count,
            let isLiked = isLiked
            else { return }
        ideaName.text = name + ": "
        likeCount.text = "\(count)"
        if isLiked {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.ideaView.backgroundColor = UIColor.green
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.ideaView.backgroundColor = UIColor.gray
            })
        }
    }
}
