//
//  TaskDetails.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskDetails: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var owner: UITextField!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var taskDescription: TextViewSubclass!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var transferButton: UIButton!
    var editButton: UIButton?
    private var lastContentOffset: CGFloat = 0
    
    var viewModel: TaskDetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        taskDescription.delegate = self
        scrollView.delegate = self 
        taskName.text = viewModel?.task?.name
        owner.text = viewModel?.task?.ownerID
        deadline.text = viewModel?.task?.deadline
        taskDescription.text = viewModel?.task?.description
        textViewDidChange(taskDescription)
        setButtonTitle()
        createEditButton()

        viewModel?.succesfulTransfer = { [weak self] in
            self?.setButtonTitle()
        }
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    
    @IBAction func progressPressed(_ sender: UIButton) {
        viewModel?.progressTask()
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        viewModel?.deleteTask()
    }

    private func createEditButton() {
        editButton = UIButton(frame: CGRect(x: view.frame.maxX - 90, y: view.frame.maxY - 120, width: 60, height: 60))
        editButton?.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        editButton?.setImage(UIImage(named: "edit_icoc"), for: .normal)
        editButton?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        guard let editButton = editButton else { return }

        editButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        editButton.layer.cornerRadius = 30
        editButton.layer.borderWidth = 1
        view.addSubview(editButton)
    }

    @objc func editPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "save_icon"), for: .normal)
        sender.removeTarget(self, action: #selector(editPressed), for: .touchUpInside)
        sender.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        taskName.isUserInteractionEnabled = true
        taskDescription.isUserInteractionEnabled = true
        deadline.isUserInteractionEnabled = true
    }

    @objc func savePressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "edit_icoc"), for: .normal)
        sender.removeTarget(self, action: #selector(savePressed), for: .touchUpInside)
        sender.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        taskName.isUserInteractionEnabled = false
        taskDescription.isUserInteractionEnabled = false
        deadline.isUserInteractionEnabled = false
        viewModel?.saveData(taskName: taskName.text, taskDescription: taskDescription.text, deadline: deadline.text)
    }

    private func setButtonTitle() {
        switch viewModel?.section {
        case "NeedsDoing":
            transferButton.setTitle("In progress", for: .normal)
        case "InProgress":
            transferButton.setTitle("Done", for: .normal)
        case "Done":
            transferButton.setTitle("Reset", for: .normal)
        default:
            return
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension TaskDetails: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estematedSize = taskDescription.sizeThatFits(size)

        descriptionHeightConstraint.constant = estematedSize.height
        descriptionViewHeight.constant = estematedSize.height + 50
    }
}

extension TaskDetails: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            // Scrolling Up
        } else if lastContentOffset < scrollView.contentOffset.y {
            // Scrolling Down
        }

        lastContentOffset = scrollView.contentOffset.y
    }
}
