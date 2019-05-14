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

    @IBOutlet weak var sectionHeaderButton: UIButton!
    @IBOutlet weak var tasks: UITableView!

    private var headers: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()

        let id = String(describing: TopicCell.self)
        tasks.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
        tasks.dataSource = self
        tasks.delegate = self
        viewModel?.dataSourceChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.headers.removeAll()
                self?.tasks.reloadData()
            }
        }
        let floatingButton = view.floatingButton()
        floatingButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(floatingButton)
        title = viewModel?.taskTopic?.name
    }

    @objc func addPressed() {
        viewModel?.navigateToAddTask?()
    }
}

extension TaskOverview: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(viewModel?.dataSource[section].isExpanded == true) {
            return 0
        }
        return viewModel?.dataSource[section].tasks.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setUpSections(section: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 60
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath)
        if let myCell = cell as? TopicCell {
            myCell.displayContent(labelText: viewModel?.dataSource[indexPath.section].tasks[indexPath.row].name)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellPressed(section: indexPath.section, index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    private func setUpSections(section: Int) -> UIView {
        let nib = UINib(nibName: "TableViewHeader", bundle: .main)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        switch section {
        case 0:
            sectionHeaderButton.setTitle("Need doing", for: .normal)
            sectionHeaderButton.backgroundColor = .clear
            sectionHeaderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            if let header = nibView.subviews[0] as? UIImageView {
                headers.append(header)
            }
        case 1:
            sectionHeaderButton.setTitle("In progress", for: .normal)
            sectionHeaderButton.backgroundColor = .clear
            sectionHeaderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            if let header = nibView.subviews[0] as? UIImageView {
                headers.append(header)
            }
        case 2:
            sectionHeaderButton.setTitle("Done", for: .normal)
            sectionHeaderButton.backgroundColor = .clear
            sectionHeaderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            if let header = nibView.subviews[0] as? UIImageView {
                headers.append(header)
            }
        default:
            sectionHeaderButton.setTitle("Programmers fault", for: .normal)
        }
        sectionHeaderButton.setTitleColor(.black, for: .normal)
        sectionHeaderButton.tag = section
        nibView.subviews[0].transform = CGAffineTransform(rotationAngle: .pi)
        return nibView
    }


    @IBAction func headerPressed(_ sender: UIButton) {
        let section = sender.tag

        var indexPaths = [IndexPath]()
        guard let indices = viewModel?.dataSource[section].tasks.indices else { return }
        for row in indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        guard let isExpanded = viewModel?.dataSource[section].isExpanded else { return }
        viewModel?.dataSource[section].isExpanded = !isExpanded

        if isExpanded {
            tasks.deleteRows(at: indexPaths, with: .fade)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.headers[section].transform = CGAffineTransform(rotationAngle: .pi / 2)
            }
        } else {
            tasks.insertRows(at: indexPaths, with: .fade)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.headers[section].transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
    }
}
