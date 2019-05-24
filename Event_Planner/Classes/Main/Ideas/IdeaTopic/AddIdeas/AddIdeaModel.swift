//
//  AddIdeaModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class AddIdeaModel {

    private var spaceKey: String?
    private var topicName: TopicDO?
    private let userService: PUserService?
    private let ideaService: PIdeaService?
    
    var ideaAdded: (() -> Void)?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, topicName: TopicDO?, userService: PUserService?, ideaService: PIdeaService?) {
        self.spaceKey = spaceKey
        self.topicName = topicName
        self.userService = userService
        self.ideaService = ideaService 
    }

    func addIdea(ideaName: String?) {
        guard
            let ideaName = ideaName,
            !ideaName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let userID = userService?.user?.userID
            else {
                errorMessage?("Please enter idea name")
                return
        }
        let newIdea = IdeaDO(ideaName: ideaName.trimmingCharacters(in: .whitespacesAndNewlines), likeCount: 1, likedPeople: ["",userID], key: nil)
        ideaService?.addIdea(spaceKey: spaceKey, topicKey: topicName?.key, idea: newIdea, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.ideaAdded?()
            } else {
                self?.errorMessage?(error)
            }
        })

    }
}
