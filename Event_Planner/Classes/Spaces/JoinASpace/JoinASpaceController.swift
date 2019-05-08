//
//  JoinASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceController: UIViewController {
    @IBOutlet weak var allSpaces: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: JoinASpaceModel?
    let throttler: Throttler = Throttler(minimumDelay: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()

        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        let id = String(describing: TopicCell.self)
        allSpaces.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
        allSpaces.dataSource = self
        allSpaces.delegate = self
        searchBar.delegate = self
        viewModel?.dataSourceChanged = {
            DispatchQueue.main.async { [weak self] in
                self?.allSpaces.reloadData()
            }
        }
    }
}

extension JoinASpaceController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredDataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(labelText: viewModel?.filteredDataSource[indexPath.row].spaceName)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed(index: indexPath.row)
    }
}

extension JoinASpaceController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.throttle { [weak self] in
            self?.viewModel?.filterSpaces(searchText: searchText)
        }
    }
}
