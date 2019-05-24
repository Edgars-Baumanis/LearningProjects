//
//  IdeaService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 27.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import Firebase

class IdeaService: PIdeaService {
    private var ref = Database.database().reference()
    private var spacesString = "Spaces"
    private var ideasString = "Ideas"

    func addTopic(topicName: String?, spaceKey: String?, completionHandler: @escaping (String?) -> Void) {
        guard
            topicName?.isEmpty != true,
            spaceKey?.isEmpty != true
            else {
            completionHandler("Please enter idea topic name")
            return
        }
        let newTopic = TopicDO(name: topicName!, key: nil)
        ref.child(spacesString).child(spaceKey!).child(ideasString).childByAutoId().setValue(newTopic.sendData())
        completionHandler(nil)
    }

    func getTopics(spaceKey: String?, completionHandler: @escaping (TopicDO?, String?) -> Void) {
        guard
            spaceKey?.isEmpty != true
            else { return }
        ref.child(spacesString).child(spaceKey!).child(ideasString).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let key = snapshot.key as? String
                else {
                    return
            }
            let newTopic = TopicDO(name: name, key: key)
            completionHandler(newTopic, nil)
        })
    }

    func getIdeas(spaceKey: String?, topicKey: String?, completionHandler: @escaping (IdeaDO?, String?) -> Void) {
        guard
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true
            else { return }
        ref.child(spacesString).child(spaceKey!).child(ideasString).child(topicKey!).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let likedPeople = post?["LikedPeople"] as? [String],
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else {
                    return
            }
            let newIdea = IdeaDO(ideaName: name, likeCount: likes, likedPeople: likedPeople, key: key)
            completionHandler(newIdea, nil)
        })
    }

    func addIdea(spaceKey: String?, topicKey: String?, idea: IdeaDO?, completionHandler: (String?) -> Void) {
        guard
            let newIdea = idea,
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true
            else {
                completionHandler("Please enter idea name")
                return
        }
        ref.child(spacesString).child(spaceKey!).child(ideasString).child(topicKey!).childByAutoId().setValue(newIdea.sendData())
        completionHandler(nil)
    }

    func addLike(spaceKey: String?, topicKey: String?, likedObject: IdeaDO, ideaKey: String?, completionHandler: (String?) -> Void) {
        guard
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true,
            ideaKey?.isEmpty != true
            else { return }
        let childUpdates = [
            "/Spaces/\(spaceKey!)/Ideas/\(topicKey!)/\(ideaKey!)" : likedObject.sendData()
        ]
        self.ref.updateChildValues(childUpdates)
        completionHandler(nil)
    }

    func reloadIdeas(spaceKey: String?, topicKey: String?, completionHandler: @escaping (IdeaDO?, String?) -> Void) {
        guard
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true
            else { return }
        ref.child(spacesString).child(spaceKey!).child(ideasString).child(topicKey!).observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let likedPeople = post?["LikedPeople"] as? [String],
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else { return }
            let newIdea = IdeaDO(ideaName: name, likeCount: likes, likedPeople: likedPeople, key: key)
            completionHandler(newIdea, nil)
        })
    }

    func removeLike(spaceKey: String?, topicKey: String?, pressedObject: IdeaDO, ideaKey: String?, completionHandler: (String?) -> Void) {
        guard
            spaceKey?.isEmpty != true,
            topicKey?.isEmpty != true,
            ideaKey?.isEmpty != true
            else { return }
        let childUpdates = [
            "/Spaces/\(spaceKey!)/Ideas/\(topicKey!)/\(ideaKey!)" : pressedObject.sendData()
        ]
        self.ref.updateChildValues(childUpdates)
        completionHandler(nil)
    }
}
