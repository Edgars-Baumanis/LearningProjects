//
//  IdeasModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeasModel {

    private var spaceKey: String?
    private var ideaService: PIdeaService?
    
    var navigateToAddTopic: (()-> Void)?
    var errorMessage: ((String?) -> Void)?
    var navigateToIdea: ((_ ideaTopic: TopicDO?) -> Void)?
    var dataSourceChanged: (() -> Void)?
    var dataSource: [TopicDO] = []
    var filteredDataSource: [TopicDO] = []
    
    init(spaceKey: String?, ideaService: PIdeaService?) {
        self.spaceKey = spaceKey
        self.ideaService = ideaService 
    } 

    func getTopics() {
        ideaService?.getTopics(spaceKey: spaceKey, completionHandler: { [weak self] (topic, error) in
            if error == nil {
                guard let newTopic = topic else { return }
                self?.dataSource.append(newTopic)
                self?.filteredDataSource.append(newTopic)
                self?.dataSourceChanged?()
            } else {
                self?.errorMessage?(error)
            }
        })
    }
}
