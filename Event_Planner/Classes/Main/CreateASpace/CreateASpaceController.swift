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
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        
        ref = Database.database().reference()
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            viewModel?.signingOut?()
        } catch let signOutError as NSError {
            print(signOutError)
        }
        
    }
    @IBAction func createSpace(_ sender: Any) {
//        let space = space {
        guard
            let name = spaceName.text,
            let password = spacePassword.text
        else { return }
        let newSpace = Space(spaceName: name, spacePassword: password)
        ref?.child("Spaces").child(name).setValue(newSpace)
    }
}
