//
//  MySpacesVC.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class MySpacesVC: UIViewController {
    let viewModel = MySpacesModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
}

extension MySpacesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        if let myCell = cell as? MySpacesCell {
            myCell.displayContent(spaceName: viewModel.cellIdentifier)
        }
        return cell
    }
    
    
}
