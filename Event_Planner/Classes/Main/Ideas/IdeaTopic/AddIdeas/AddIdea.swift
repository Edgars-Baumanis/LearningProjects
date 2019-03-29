//
//  AddIdea.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddIdea: UIViewController {
    @IBOutlet weak var ideaName: TextFieldSubclass!
    var viewModel: AddIdeaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    @IBAction func addIdeaPressed(_ sender: UIButton) {
        viewModel?.addIdea(ideaName: ideaName.text)
    }
}
