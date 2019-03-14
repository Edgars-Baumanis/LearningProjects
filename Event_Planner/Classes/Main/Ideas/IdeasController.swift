//
//  IdeasController.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 08.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeasController: UIViewController {
    @IBOutlet weak var allIdeas: UITableView!
    @IBOutlet weak var allIdeasSearchBar: UISearchBar!

    var viewModel: IdeasModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        allIdeas.delegate = self
        allIdeas.dataSource = self

        let addTopic = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTopicPressed))
        self.navigationItem.rightBarButtonItem = addTopic
    }

    @objc func addTopicPressed(sender: UIBarButtonItem) {
        viewModel?.addTopicPressed?()
    }
}

extension IdeasController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(subject: "String")
        }
        return cell
    }


}
