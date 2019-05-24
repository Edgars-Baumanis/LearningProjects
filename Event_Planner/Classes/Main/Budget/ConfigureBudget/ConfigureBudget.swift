//
//  ConfigureBudget.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ConfigureBudget: UIViewController {
    @IBOutlet weak var fieldName: TextFieldSubclass!
    @IBOutlet weak var fieldSum: TextFieldSubclass!
    var viewModel: ConfigureModel?
    private var addTap: (() -> Void)?
    private var removeTap: (() -> Void)?
    private var isEdited = false
    private var saveButtonCenter: CGPoint?
    private var saveButton: UIButton?

    override func viewWillAppear(_ animated: Bool) {
        fieldName.text = viewModel?.budgetField?.name
        fieldSum.text = viewModel?.budgetField?.sum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        fieldName.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        fieldSum.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        saveButton = UIButton(frame: CGRect(x: view.frame.maxX - 90, y: view.frame.maxY - 90, width: 0, height: 0))
        saveButtonCenter = saveButton?.center
        saveButton?.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        saveButton?.setImage(UIImage(named: "save_icon"), for: .normal)
        saveButton?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        guard let saveButton = saveButton else { return }
        view.addSubview(saveButton)
        addHandlers()
        handleKeyboard()

    }

    private func addHandlers() {
        viewModel?.errorMessage = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }

    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addTap = { [weak self] in
            self?.view.addGestureRecognizer(tap)
        }
        removeTap = { [weak self] in
            self?.view.removeGestureRecognizer(tap)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        removeTap?() 
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height - self.view.frame.height / 4.5
        }
        if saveButton?.center == saveButtonCenter {
            if isEdited {
                saveButton?.frame = CGRect(x: keyboardFrame.maxX - 120, y: keyboardFrame.minY - 70, width: 60, height: 60)
            } else {
                saveButton?.frame = CGRect(x: keyboardFrame.maxX - 120, y: keyboardFrame.minY - 70, width: 0, height: 0)
            }
        }
        addTap?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        if saveButton?.center != saveButtonCenter {
            guard let saveButtonCenter = saveButtonCenter else { return }
            saveButton?.center = saveButtonCenter
        }
    }

    @objc func textFieldTextDidChange(_ textField: UITextField) {
        fieldCheck()
    }

    @objc func savePressed(sender: UIBarButtonItem) {
        viewModel?.savePressed(fieldName: fieldName.text, fieldSum: fieldSum.text)
    }

    private func fieldCheck() {
        if fieldName.text != viewModel?.budgetField?.name || fieldSum.text != viewModel?.budgetField?.sum {
            createSaveIcon()
        } else {
            hideSaveIcon()
        }
    }

    private func createSaveIcon() {
        isEdited = true
        saveButton?.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.saveButton?.frame.size.height = 60
            self?.saveButton?.frame.size.width = 60
            self?.saveButton?.layer.cornerRadius = 30
            self?.saveButton?.layer.borderWidth = 1
        }
    }

    private func hideSaveIcon() {
        isEdited = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.saveButton?.frame.size.height = 0
            self?.saveButton?.frame.size.width = 0
            self?.saveButton?.layer.cornerRadius = 0
            self?.saveButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
