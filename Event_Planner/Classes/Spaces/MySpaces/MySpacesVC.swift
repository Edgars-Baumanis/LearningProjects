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
        viewModel?.dataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.mySpaces.reloadData()
                self?.otherSpaces.reloadData()
            }
        }

        let tabbar = self.tabBarController?.tabBar
        tabbar?.barTintColor = UIColor.black
        tabbar?.tintColor = UIColor.lightYellow
        tabbar?.unselectedItemTintColor = UIColor.gray
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        viewModel?.navigateToCreate?()
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        viewModel?.signOut()
    }
}

extension MySpacesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == otherSpaces {
            return viewModel?.otherSpaces.count ?? 0
        } else {
            return viewModel?.mySpaces.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = tableView == otherSpaces ?
            String(describing: OtherSpacesCell.self) :
            String(describing: MySpacesCell.self)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        (cell as? OtherSpacesCell)?.displayContent(spaceName: viewModel?.otherSpaces[indexPath.row].spaceName)
        (cell as? MySpacesCell)?.displayContent(spaceName: viewModel?.mySpaces[indexPath.row].spaceName)

        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.3, delayFactor: 0.1)
        let animator = Animations(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView == otherSpaces ?
            viewModel?.otherSpacePressed(index: indexPath.row) :
            viewModel?.mySpacePressed(index: indexPath.row)
    }
}


