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
    var tap: UITapGestureRecognizer?
    var viewModel: IdeasModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allIdeas.delegate = self
        allIdeas.dataSource = self
        allIdeasSearchBar.delegate = self
        viewModel?.getTopics()
        viewModel?.dataSourceChanged = { [weak self] in
            self?.allIdeas.reloadData()
        }
        floatingButton()
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        allIdeasSearchBar.showsCancelButton = false
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
        btn.addTarget(self, action: #selector(addTopicPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addTopicPressed() {
        viewModel?.navigateToAddTopic?()
    }
}

extension IdeasController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredDataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(subject: viewModel?.filteredDataSource?[indexPath.row].name ?? "Something went wrong")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToIdea?(viewModel?.filteredDataSource?[indexPath.row])
    }
}

extension IdeasController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filteredDataSource = searchText.isEmpty ? viewModel?.dataSource : viewModel?.dataSource.filter { (item: IdeaTopicStruct) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        allIdeas.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        view.addGestureRecognizer(tap!)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tap!)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
