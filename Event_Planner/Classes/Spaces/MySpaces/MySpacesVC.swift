//
//  MySpacesVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class MySpacesVC: UIViewController {

    var viewModel: MySpacesModel?
    
    @IBOutlet weak var otherSpaces: UITableView!
    @IBOutlet weak var mySpaces: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        otherSpaces.delegate = self
        otherSpaces.dataSource = self
        mySpaces.delegate = self
        mySpaces.dataSource = self
        viewModel?.getData()

        viewModel?.dataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.mySpaces.reloadData()
                self?.otherSpaces.reloadData()
            }
        }
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        viewModel?.navigateToCreate?()
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            viewModel?.signingOut?()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
}

extension MySpacesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellIdentifier = tableView == otherSpaces ? String(describing: OtherSpacesCell.self) : String(describing: MySpacesCell.self)
        if cellIdentifier == String(describing: MySpacesCell.self) {
            return viewModel?.mySpacesDataSource?.count ?? 0
        } else {
            return viewModel?.otherSpacesDataSource?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = tableView == otherSpaces ? String(describing: OtherSpacesCell.self) : String(describing: MySpacesCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        (cell as? OtherSpacesCell)?.displayContent(spaceName: viewModel?.otherSpacesDataSource?[indexPath.row].spaceName ?? "Nothing to show")
        (cell as? MySpacesCell)?.displayContent(spaceName: viewModel?.mySpacesDataSource?[indexPath.row].spaceName ?? "Nothing to show")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView == otherSpaces ? viewModel?.navigateToMainFlow?((viewModel?.otherSpacesDataSource?[indexPath.row])!) : viewModel?.navigateToMainFlow?((viewModel?.mySpacesDataSource?[indexPath.row])!)
    }
}


