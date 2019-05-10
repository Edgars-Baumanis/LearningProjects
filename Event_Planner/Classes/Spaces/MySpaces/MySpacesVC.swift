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
    private let mySpacesID = "MySpacesCell"
    private let otherSpacesID = "OtherCells"
    
    @IBOutlet weak var mySpaces: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        mySpaces.delegate = self
        mySpaces.dataSource = self

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.dataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.mySpaces.reloadData()
            }
        }
    }

    func confNavBar() {
        title = "Spaces"
        let barButtonImage = UIImage(named: "user-Icon")
        let profile = UIBarButtonItem(title: "profile", style: .plain, target: self, action: #selector(profilePressed))
        profile.image = barButtonImage
        navigationItem.leftBarButtonItem = profile

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

    @objc func profilePressed(_ sender: UIBarButtonItem) {
        viewModel?.toProfile?()
    }
    @IBAction func joinSpacePressed(_ sender: UIButton) {
        showMoreButtons(pressed: FABPressed)
    }

    @objc func joinPressed(_ sender: UIButton) {
        showMoreButtons(pressed: FABPressed)
        viewModel?.joinPressed?()

    }

    @objc func createPressed(_ sender: UIButton) {
        showMoreButtons(pressed: FABPressed)
        viewModel?.navigateToCreate?()
    }

    private func showMoreButtons(pressed: Bool) {
        FABPressed = !pressed
        if pressed != true {
            joinButton?.layer.borderWidth = 1
            joinButton?.layer.cornerRadius = 35
            joinButton?.backgroundColor = .white
            joinButton?.setTitle("Join", for: .normal)
            joinButton?.setTitleColor(.black, for: .normal)
            joinButton?.addTarget(self, action: #selector(joinPressed), for: .touchUpInside)
            joinButton?.alpha = 0.7
            createButton?.layer.borderWidth = 1
            createButton?.layer.cornerRadius = 35
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
                self?.joinButton?.frame = CGRect(x: midX - buttonWidth * 11.5, y: maxY - maxY / 6.5, width: 70, height: 70)
                self?.createButton?.frame = CGRect(x: midX + buttonWidth * 4.5, y: maxY - maxY / 6.5, width: 70, height: 70)
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.spaces.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = viewModel?.spaces[indexPath.row].mainUser == viewModel?.currentUser ? mySpacesID : otherSpacesID
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        (cell as? MySpacesCell)?.displayContent(spaceName: viewModel?.spaces[indexPath.row].spaceName)
        (cell as? OtherCells)?.displayContent(name: viewModel?.spaces[indexPath.row].spaceName)

        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.3, delayFactor: 0.1)
        let animator = Animations(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.mySpacePressed(section: indexPath.section, index: indexPath.row)
    }
} 


