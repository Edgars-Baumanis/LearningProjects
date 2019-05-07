//
//  EditAccountVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 15.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class EditAccountVC: UIViewController {
    @IBOutlet weak var newUsername: UITextField!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var password: UITextField!

    var viewModel: EditAccountModel?
    var saveButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        newUsername.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        newEmail.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)

        newUsername.text = viewModel?.user?.userName
        newEmail.text = viewModel?.user?.email
        saveButton = UIButton(frame: CGRect(x: view.frame.maxX - 90, y: view.frame.maxY - 120, width: 0, height: 0))
        saveButton?.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        saveButton?.setImage(UIImage(named: "save_icon"), for: .normal)
        saveButton?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        guard let saveButton = saveButton else { return } 
        view.addSubview(saveButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fieldCheck()
    }

    @objc func textFieldTextDidChange(_ textField: UITextField) {
        fieldCheck()
    }

    @objc func savePressed(_ sender: UIButton) {
        viewModel?.changeAccDetails(newEmail: newEmail.text, newUsername: newUsername.text)
    }

    private func fieldCheck() {
        if newUsername.text != viewModel?.user?.userName || newEmail.text != viewModel?.user?.email {
            createSaveIcon()
        } else {
            hideSaveIcon()
        }
    }

    private func createSaveIcon() {
        saveButton?.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.saveButton?.frame.size.height = 60
            self?.saveButton?.frame.size.width = 60
            self?.saveButton?.layer.cornerRadius = 30
            self?.saveButton?.layer.borderWidth = 1
        }
    }

    private func hideSaveIcon() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.saveButton?.frame.size.height = 0
            self?.saveButton?.frame.size.width = 0
            self?.saveButton?.layer.cornerRadius = 0
            self?.saveButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
