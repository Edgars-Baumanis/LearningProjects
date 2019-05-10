//
//  JoinASapceModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class JoinASpaceModel {

    private var userService: PUserService?
    private var spaceService: PSpacesService?
    private var throttler: Throttler?

    init(userService: PUserService?, spaceService: PSpacesService?) {
        self.userService = userService
        self.spaceService = spaceService
        self.throttler = Throttler(minimumDelay: 0.5)
        getSpaces()
    }
    var backPressed: (() -> Void)?
    var dataSource = [SpaceDO]()
    var filteredDataSource = [SpaceDO]()
    var spacePressed: ((SpaceDO?) -> Void)?
    var dataSourceChanged: (() -> Void)?

    private func getSpaces() {
        spaceService?.getAllSpaces(completionHandler: { [weak self] (spaces) in
            self?.dataSource = spaces
            self?.filteredDataSource = spaces
            self?.dataSourceChanged?()
        })
    }

    func cellPressed(index: Int) {
        spacePressed?(dataSource[index])
    }

    func filterSpaces(searchText: String) {
        filteredDataSource.removeAll()
        if searchText.isEmpty {
            filteredDataSource = dataSource
            dataSourceChanged?()
        } else {
            for space in dataSource {
                if space.spaceName.lowercased().contains(searchText.lowercased()) {
                    filteredDataSource.append(space)
                    dataSourceChanged?()
                }
            }
        }
    }
}
