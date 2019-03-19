//
//  IdeaTopic.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeaTopic: UIViewController {

    @IBOutlet weak var ideas: UITableView!
    var viewModel: IdeaTopicModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        self.title = viewModel?.topicName
        ideas.delegate = self
        ideas.dataSource = self
    }
}

extension IdeaTopic: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IdeaCell.self), for: indexPath)
        if let myCell = cell as? IdeaCell {
            myCell.displayContent(name: "String", count: 12)
        }
        return cell
    }
}
