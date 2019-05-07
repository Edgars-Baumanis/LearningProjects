//
//  UserProfileVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!

    var viewModel: UserProfileModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        username.text = viewModel?.user?.userName
        email.text = viewModel?.user?.email
    }
    
    @IBAction func removeIconPressed(_ sender: UIButton) {
    }

    @IBAction func editAccountPressed(_ sender: UIButton) {
        viewModel?.toEditAccount?()
    }

    @IBAction func changePasswordPressed(_ sender: UIButton) {
    }

    @IBAction func logoutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "You are about to logout", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] action in
            self?.viewModel?.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "You are about to delete your Account", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete Account", style: .destructive, handler: { [weak self] (action) in
            self?.viewModel?.deleteAcc()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
