//
//  ConfigureBudget.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class ConfigureBudget: UIViewController {
    
    @IBOutlet weak var fieldTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        fieldTable.delegate = self
        fieldTable.dataSource = self
        
    }
    @IBAction func addFieldPressed(_ sender: Any) {
        
    }
}


extension ConfigureBudget: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FieldCell.self), for: indexPath)
        if let myCell = cell as? FieldCell {
            myCell.displayContent(name: "String", sum: 30.1)
        }
        return cell
    }
}
