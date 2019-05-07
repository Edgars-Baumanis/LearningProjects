//
//  TasksController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TasksController: UIViewController {

    var viewModel: TasksModel?

    @IBOutlet weak var allTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        let id = String(describing: TopicCell.self)


        allTasks.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
        allTasks.delegate = self
        allTasks.dataSource = self
        viewModel?.getTaskTopics()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allTasks.reloadData()
        }
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        let btn = view.floatingButton()
        btn.addTarget(self, action: #selector(addTaskPressed), for: .touchUpInside)
        view.addSubview(btn)
    }


    @objc func addTaskPressed(sender: UIBarButtonItem) {
        viewModel?.addTaskPressed?()
    }
}

extension TasksController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredDataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: TopicCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(labelText: viewModel?.filteredDataSource[indexPath.row].name)
        }

        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animations(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed?((viewModel?.dataSource[indexPath.row])!)
    }
}

