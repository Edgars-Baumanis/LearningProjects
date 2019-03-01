//
//  CreateASpaceController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase


struct Space {
    let spaceName: String?
    let spacePassword: String?
    
    init (spaceName: String, spacePassword: String) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
    }
    
    func sendData() -> Any {
        return [
            "name": spaceName,
            "password": spacePassword
        ]
    }
}


class CreateASpaceController: UIViewController {
    @IBOutlet weak var spaceName: UITextField!
    @IBOutlet weak var spacePassword: UITextField!
    @IBOutlet weak var spaceDescription: UITextField!
    
    var viewModel: CreateASpaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        
    }
    
    @IBAction func createSpace(_ sender: Any) {
        viewModel?.createASpace(name: spaceName.text, password: spacePassword.text, description: spaceDescription.text)
    }
    @IBAction func closePressed(_ sender: Any) {
        viewModel?.backPressed?()
    }
}