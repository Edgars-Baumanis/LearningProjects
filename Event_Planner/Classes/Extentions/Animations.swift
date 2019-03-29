//
//  Animations.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 29.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

class Animations {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else { return }
        animation(cell, indexPath, tableView)
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
