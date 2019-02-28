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
    var ref: DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        
        ref = Database.database().reference()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
