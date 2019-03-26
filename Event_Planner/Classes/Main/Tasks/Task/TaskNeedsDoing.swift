//
//  TaskNeedsDoing.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskNeedsDoing: UIViewController {
    @IBOutlet weak var tasksNeedDoing: UITableView!
    var viewModel: TaskNeedsDoingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        tasksNeedDoing.delegate = self
        tasksNeedDoing.dataSource = self
        viewModel?.getData()
        viewModel?.dataDeleted()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.tasksNeedDoing.reloadData()
        }
        floatingButton()
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 300, y: 550, width: 50, height: 50)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 24
        btn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addPressed(sender: UIButton) {
        viewModel?.navigateToAddTask?()
    }
}

extension TaskNeedsDoing: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskNeedsDoingCell.self), for: indexPath)
        if let myCell = cell as? TaskNeedsDoingCell {
            myCell.displayContent(name: viewModel?.dataSource[indexPath.row].name ?? "Default Value")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToDetails?(viewModel?.dataSource[indexPath.row])
    }
}
