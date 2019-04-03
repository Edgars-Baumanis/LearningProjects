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
    
    @IBOutlet weak var mySpaces: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        mySpaces.delegate = self
        mySpaces.dataSource = self
        viewModel?.dataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.mySpaces.reloadData()
            }
        }
        confNavBar()

        let tabbar = self.tabBarController?.tabBar
        tabbar?.barTintColor = UIColor.black
        tabbar?.tintColor = UIColor.lightYellow
        tabbar?.unselectedItemTintColor = UIColor.gray
    }

    func confNavBar() {
        title = "Spaces"
        let backButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
        navigationItem.leftBarButtonItem = backButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusPressed))
        navigationItem.rightBarButtonItem = addButton

        let nav = self.navigationController
        nav?.navigationBar.barStyle = .blackTranslucent
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
        nav?.navigationBar.tintColor = UIColor.black
        nav?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        viewModel?.navigateToCreate?()
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        viewModel?.signOut()
    }
}

extension MySpacesVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.spaces.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.spaces[section].count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()

        switch section {
        case 0:
            label.text = "My Spaces"
            label.backgroundColor = UIColor.red
        case 1:
            label.text = "Joined Spaces"
            label.backgroundColor = UIColor.yellow
        default:
            label.text = "Programmers fck up"
        }
        
        label.textAlignment = .center
        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel?.spaces[section].isEmpty == true {
            return 0
        } else { return 60 }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MySpacesCell.self), for: indexPath)

        if let myCell = cell as? MySpacesCell {
            myCell.displayContent(spaceName: viewModel?.spaces[indexPath.section][indexPath.row].spaceName)
        }

        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.3, delayFactor: 0.1)
        let animator = Animations(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.mySpacePressed(section: indexPath.section, index: indexPath.row)
    }
}


