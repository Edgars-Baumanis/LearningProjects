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
    @IBOutlet weak var allIdeasSearchBar: UISearchBar!

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
        floatingButton()
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(addTopicPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addTopicPressed(sender: UIBarButtonItem) {
        viewModel?.addTopicPressed?()
    }
}

extension IdeasController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(subject: viewModel?.dataSource[indexPath.row].name ?? "Something went wrong")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed?(viewModel?.dataSource[indexPath.row])
    }

}
