//
//  IdeaTopicModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeaTopicModel {

    private var spaceKey: String?
    private var userServices: PUserService?
    private var ideaService: PIdeaService?

    var errorMessage: ((String?) -> Void)?
    var topicName: TopicDO?
    var addPressed: (() -> Void)?
    var dataSource: [IdeaDO] = []
    var dataSourceChanged: (() -> Void)?

    init(topicName: TopicDO?, spaceKey: String?, userServices: PUserService?, ideaService: PIdeaService?) {
        self.userServices = userServices
        self.topicName = topicName
        self.ideaService = ideaService
        self.spaceKey = spaceKey
        reloadData()
        getData()
    }

    func getData() {
        ideaService?.getIdeas(spaceKey: spaceKey, topicKey: topicName?.key, completionHandler: { [weak self] (idea, error) in
            if error == nil {
                guard let newIdea = idea else { return }
                self?.dataSource.append(newIdea)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func addLike(index: Int) {
        guard let userID = userServices?.user?.userID else { return }
        if dataSource[index].likedPeople.contains(userID) != true {
            dataSource[index].likedPeople.append(userID)
            let likedField = dataSource[index]
            let newField = IdeaDO(ideaName: likedField.ideaName, likeCount: likedField.likeCount + 1, likedPeople: likedField.likedPeople, key: nil)
            ideaService?.addLike(spaceKey: spaceKey, topicKey: topicName?.key, likedObject: newField, ideaKey: likedField.key, completionHandler: { [weak self] error in
                if error == nil {
                    return
                } else {
                    self?.errorMessage?(error)
                }
            })
        }
    }

    func reloadData() {
        ideaService?.reloadIdeas(spaceKey: spaceKey, topicKey: topicName?.key, completionHandler: { [weak self] (changedIdea, error) in
            if error == nil {
                var index: Int?
                self?.dataSource.enumerated().forEach { (idx, value) in
                    if value.key == changedIdea?.key {
                        index = idx
                    }
                }
                guard let idx = index, let newIdea = changedIdea else { return }
                self?.dataSource[idx] = newIdea
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })

    }
}
