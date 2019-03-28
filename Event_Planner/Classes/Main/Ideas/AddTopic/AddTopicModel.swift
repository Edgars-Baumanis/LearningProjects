//
//  AddTopicModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddTopicModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?
    private var ideaService : PIdeaService?
    
    var addTopicPressed: (() -> Void)?
    var errorMessage: ((String?) -> Void)?


    init(spaceKey: String?, ideaService: PIdeaService?) {
        self.spaceKey = spaceKey
        self.ideaService = ideaService
        ref = Database.database().reference()
    }

    func addTopic(topicName: String?) {
        ideaService?.addTopic(topicName: topicName, spaceKey: spaceKey, completionHandler: { [weak self] (error) in
            if error == nil {
                self?.addTopicPressed?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
