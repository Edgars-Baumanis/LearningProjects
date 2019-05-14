//
//  EventUserController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 13.05.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class EventUserController: UIViewController {

    @IBOutlet weak var eventUsers: UITableView!
    var viewModel: EventUserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        addHandlers()
        eventUsers.delegate = self
        eventUsers.dataSource = self
    }

    private func addHandlers() {
        viewModel?.dataSourceChanged = {
            DispatchQueue.main.async { [weak self] in
                self?.eventUsers.reloadData()
            }
        }
        viewModel?.errorMessage = { [weak self] (error) in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
}

extension EventUserController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = viewModel?.isOwner(index: indexPath.row) == true ? String(describing: EventOwnerCell.self) : String(describing: EventUserCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        (cell as? EventUserCell)?.displayContent(userName: viewModel?.dataSource[indexPath.row].userName)

        (cell as? EventOwnerCell)?.displayContent(userName: viewModel?.dataSource[indexPath.row].userName)

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if viewModel?.isOwner() == true {
            return true
        } else {
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteUser(index: indexPath.row)
        }
    }
}
