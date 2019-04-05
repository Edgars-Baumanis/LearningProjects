//
//  IdeasController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeasController: UIViewController {
    @IBOutlet weak var allIdeas: UITableView!
    var viewModel: IdeasModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allIdeas.delegate = self
        allIdeas.dataSource = self
        viewModel?.getTopics()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allIdeas.reloadData()
        }
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        let btn = view.floatingButton()
        btn.addTarget(self, action: #selector(addTopicPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addTopicPressed() {
        viewModel?.navigateToAddTopic?()
    }
}

extension IdeasController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredDataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        

        if let myCell = cell as? TopicCell {
            myCell.displayContent(subject: viewModel?.filteredDataSource[indexPath.row].name)
        }
        
        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animations(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToIdea?(viewModel?.filteredDataSource[indexPath.row])
    }
}
