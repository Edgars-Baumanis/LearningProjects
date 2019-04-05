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
    private var FABPressed = false

    private var joinButton: UIButton?
    private var createButton: UIButton?
    
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
        joinButton = UIButton(frame: CGRect(x: view.frame.midX, y: view.frame.maxY, width: 10, height: 10))
        createButton = UIButton(frame: CGRect(x: view.frame.midX, y: view.frame.maxY, width: 10, height: 10))
        guard let createButton = createButton, let joinButton = joinButton else { return }
        view.addSubview(createButton)
        view.addSubview(joinButton)

    }

    func confNavBar() {
        title = "Spaces"
        let backButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
        navigationItem.leftBarButtonItem = backButton

        let nav = self.navigationController
        nav?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav?.navigationBar.shadowImage = UIImage()
        nav?.navigationBar.tintColor = UIColor.black
        nav?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        nav?.navigationBar.prefersLargeTitles = true

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }

    @objc func signOutPressed(_ sender: UIBarButtonItem) {
        viewModel?.signOut()
    }
    @IBAction func joinSpacePressed(_ sender: UIButton) {
        showMoreButtons(pressed: FABPressed)
    }

    @objc func joinPressed(_ sender: UIButton) {
        buttonsAlreadyThere()
        viewModel?.joinPressed?()

    }

    @objc func createPressed(_ sender: UIButton) {
        buttonsAlreadyThere()
        viewModel?.navigateToCreate?()
    }

    private func showMoreButtons(pressed: Bool) {
        FABPressed = !pressed
        if pressed != true {
            joinButton?.layer.borderWidth = 1
            joinButton?.layer.cornerRadius = 30
            joinButton?.backgroundColor = .white
            joinButton?.setTitle("Join", for: .normal)
            joinButton?.setTitleColor(.black, for: .normal)
            joinButton?.addTarget(self, action: #selector(joinPressed), for: .touchUpInside)
            joinButton?.alpha = 0.7
            createButton?.layer.borderWidth = 1
            createButton?.layer.cornerRadius = 30
            createButton?.backgroundColor = .white
            createButton?.alpha = 0.7
            createButton?.setTitle("Create", for: .normal)
            createButton?.setTitleColor(.black, for: .normal)
            createButton?.addTarget(self, action: #selector(createPressed), for: .touchUpInside)

            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard
                    let midX = self?.view.frame.midX,
                    let maxY = self?.view.frame.maxY,
                    let buttonWidth = self?.joinButton?.frame.width
                    else { return }
                self?.joinButton?.frame = CGRect(x: midX - buttonWidth * 10, y: maxY - maxY / 6.5, width: 60, height: 60)
                self?.createButton?.frame = CGRect(x: midX + buttonWidth * 4, y: maxY - maxY / 6.5, width: 60, height: 60)
            })

        } else {
            buttonsAlreadyThere()
        }
    }

    private func buttonsAlreadyThere() {
        joinButton?.setTitle("", for: .normal)
        createButton?.setTitle("", for: .normal)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard
                let midX = self?.view.frame.midX,
                let maxY = self?.view.frame.maxY
                else { return }
            self?.joinButton?.frame = CGRect(x: midX , y: maxY + 10, width: 10, height: 10)
            self?.createButton?.frame = CGRect(x: midX, y: maxY + 10, width: 10, height: 10)
        })
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
        return setUpSections(section: section)
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

    private func setUpSections(section: Int) -> UIView {
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 10, width: sectionHeaderView.frame.width - 20, height: sectionHeaderView.frame.height - 10))

        switch section {
        case 0:
            sectionLabel.text = "My Spaces"
        case 1:
            sectionLabel.text = "Joined Spaces"
        default:
            sectionLabel.text = "Programmers fck up"
        }
        sectionLabel.layer.borderWidth = 1
        sectionLabel.layer.cornerRadius = 15
        sectionLabel.textAlignment = .center
        sectionHeaderView.addSubview(sectionLabel)
        return sectionHeaderView
    }
}


