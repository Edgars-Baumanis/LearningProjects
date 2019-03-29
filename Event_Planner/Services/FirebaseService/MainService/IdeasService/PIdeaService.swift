//
//  PIdeaService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 27.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PIdeaService {
    func addTopic(topicName: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void)

    func getTopics(spaceKey: String?, completionHandler: @escaping (TopicDO?, String?) -> Void)

    func getIdeas(spaceKey: String?, topicKey: String?, completionHandler: @escaping (IdeaDO?, String?) -> Void)

    func addIdea(spaceKey: String?, topicKey: String?, idea: IdeaDO?, completionHandler: (String?) -> Void)

    func addLike(spaceKey: String?, topicKey: String?, likedObject: IdeaDO, ideaKey: String?, completionHandler: (String?) -> Void)

    func reloadIdeas(spaceKey: String?, topicKey: String?, completionHandler: @escaping (IdeaDO?, String?) -> Void)

    func removeLike(spaceKey: String?, topicKey: String?, pressedObject: IdeaDO, ideaKey: String?, completionHandler: (String?) -> Void)
}
