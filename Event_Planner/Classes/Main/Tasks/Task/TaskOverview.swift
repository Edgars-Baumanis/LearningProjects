//
//  TaskOverview.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 01.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class TaskOverview: UIViewController {
    var viewModel: TaskOverviewModel?

    @IBOutlet weak var tasks: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        tasks.dataSource = self
        tasks.delegate = self
        viewModel?.dataSourceChanged = { [weak self] in
            self?.tasks.reloadData()
        }
        floatingButton()
        title = viewModel?.taskTopic?.name
    }

    func floatingButton() {
        let btn = UIButton(frame: CGRect(x: view.frame.maxX - 90 , y: view.frame.maxY - 90, width: 70, height: 70))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
        btn.setTitle("+", for: .normal)
        btn.setFloatingButtonGradient()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 34
        btn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func addPressed() {
        viewModel?.navigateToAddTask?()
    }
}

extension TaskOverview: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource[section].count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setUpSections(section: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel?.dataSource[section].isEmpty == true {
            return 0
        } else {
            return 60
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath)
        if let myCell = cell as? TaskCell {
            myCell.displayContent(name: viewModel?.dataSource[indexPath.section][indexPath.row].name)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed(section: indexPath.section, index: indexPath.row)
    }

    private func setUpSections(section: Int) -> UIView {
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 10, width: sectionHeaderView.frame.width - 20, height: sectionHeaderView.frame.height - 20))

        switch section {
        case 0:
            sectionLabel.text = "Need doing"
            sectionLabel.layer.backgroundColor = UIColor.red.cgColor
        case 1:
            sectionLabel.text = "In progress"
            sectionLabel.layer.backgroundColor = UIColor.yellow.cgColor
        case 2:
            sectionLabel.text = "Done"
            sectionLabel.layer.backgroundColor = UIColor.green.cgColor
        default:
            sectionLabel.text = "Programmers fck up"
        }
        sectionLabel.layer.borderWidth = 1
        sectionLabel.layer.cornerRadius = 15
        sectionLabel.textAlignment = .center
        sectionHeaderView.addSubview(sectionLabel)
        sectionHeaderView.setCellBackground()
        return sectionHeaderView
    }
}
