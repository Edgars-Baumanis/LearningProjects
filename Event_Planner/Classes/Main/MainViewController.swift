//
//  MainViewController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var leaveEventButton: UIButton!
    
    var viewModel: MainModel?
    var leavingEventMessage: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        title = viewModel?.space?.spaceName
        changeLeaveButton()

        let nav = self.navigationController?.navigationBar
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        makeInfoButton()
    }

    private func changeLeaveButton() {
        if viewModel?.isOwner() == true {
            leaveEventButton.setTitle("Delete event", for: .normal)
            leavingEventMessage = { [weak self] in
                let alert = UIAlertController(title: "Are you sure", message: "You are about to delete the event", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    let alert = UIAlertController(title: "Completely sure", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                        self?.viewModel?.deleteEvent()
                    }))
                    self?.present(alert, animated: true)
                }))
                self?.present(alert, animated: true)
            }
        } else {
            leavingEventMessage = { [weak self] in
                let alert = UIAlertController(title: "Are you sure", message: "You are about to leave this event", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { (action) in
                    self?.viewModel?.leaveEvent()
                }))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func chatPressed(_ sender: UIButton) {
        viewModel?.chatPressed?()
    }

    @IBAction func budgetPressed(_ sender: UIButton) {
        viewModel?.budgetPressed?()
    }

    @IBAction func tasksPressed(_ sender: UIButton) {
        viewModel?.tasksPressed?()
    }

    @IBAction func ideasPressed(_ sender: UIButton) {
        viewModel?.ideasPressed?()
    }

    private func makeInfoButton() {
        let infoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        infoButton.addTarget(self, action: #selector(infoPressed), for: .touchUpInside)
        infoButton.setImage(UIImage(named: "user-Icon"), for: .normal)
        let barInfoButton = UIBarButtonItem(customView: infoButton)
        NSLayoutConstraint.activate([barInfoButton.customView!.widthAnchor.constraint(equalToConstant: 40), barInfoButton.customView!.heightAnchor.constraint(equalToConstant: 40)])

        navigationItem.setRightBarButton(barInfoButton, animated: true)
    }
    
    @IBAction func leaveEventPressed(_ sender: UIButton) {
        leavingEventMessage?()
    }

    @objc private func infoPressed(_ sender: UIBarButtonItem) {
        viewModel?.infoPressed?()
    }
}
