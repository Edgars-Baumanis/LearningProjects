//
//  UITableView.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 29.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}
