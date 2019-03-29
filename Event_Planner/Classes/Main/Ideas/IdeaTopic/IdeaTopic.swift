//
//  IdeaTopic.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeaTopic: UIViewController {

    @IBOutlet weak var ideas: UITableView!
    var viewModel: IdeaTopicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        self.title = viewModel?.topicName?.name
        viewModel?.dataSourceChanged = { [weak self] in
            self?.ideas.reloadData()
        }
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        ideas.delegate = self
        ideas.dataSource = self
        floatingButton()

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
    }

    func floatingButton() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 280, y: 570, width: 60, height: 60)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addPressed(sender: UIBarButtonItem) {
        viewModel?.addPressed?()
    }
}

extension IdeaTopic: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IdeaCell.self), for: indexPath)
        if let myCell = cell as? IdeaCell {
            myCell.displayContent(
                name: viewModel?.dataSource[indexPath.row].ideaName,
                count: viewModel?.dataSource[indexPath.row].likeCount,
                isLiked: viewModel?.isLiked(index: indexPath.row))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.addLike(index: indexPath.row)
    }
}
