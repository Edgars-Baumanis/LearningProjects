//
//  CreateASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase


class CreateASpaceController: UIViewController {
    @IBOutlet weak var spaceName: UITextField!
    @IBOutlet weak var spacePassword: UITextField!
    @IBOutlet weak var spaceDescription: TextViewSubclass!
    
    var viewModel: CreateASpaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        spaceDescription.delegate = self
        spaceDescription.text = "Enter a description for your Space"
        spaceDescription.textColor = UIColor.placholderGrey
        viewModel?.printEmail()
    }
    
    @IBAction func createSpace(_ sender: Any) {
        viewModel?.createASpace(name: spaceName.text, password: spacePassword.text, description: spaceDescription.text)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        viewModel?.backPressed?()
    }
}

extension CreateASpaceController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if spaceDescription.textColor == UIColor.placholderGrey {
            spaceDescription.text = nil
            spaceDescription.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if spaceDescription.text.isEmpty {
            spaceDescription.text = "Enter a description for your Space"
            spaceDescription.textColor = UIColor.placholderGrey
        }
    }
}
