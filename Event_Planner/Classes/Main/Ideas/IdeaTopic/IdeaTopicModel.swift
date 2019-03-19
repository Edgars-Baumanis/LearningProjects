//
//  IdeaTopicModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 18.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class IdeaTopicModel {
    private var ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private var spaceName: String?
    var topicName: String?
    var addPressed: (() -> Void)?
    var dataSource: [Idea] = []
    var dataSourceChanged: (() -> Void)?

    init(topicName: String?, spaceName: String?) {
        self.topicName = topicName
        self.spaceName = spaceName
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
    }

    func getData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Ideas").child(topicName!).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else { return }
            let newIdea = Idea(ideaName: name, likeCount: likes, key: key)

            self.dataSource.append(newIdea)
            self.dataSourceChanged?()
        })
    }

    func addLike(index: Int) {
        let likedField = dataSource[index]
        let newField = Idea(ideaName: likedField.ideaName, likeCount: likedField.likeCount + 1, key: nil)
        guard let key = likedField.key, let newTopicName = topicName else { return }
        let childUpdates = [
            "/Spaces/\(spaceName!)/Ideas/\(newTopicName)/\(key)" : newField.sendData()
        ]
        ref?.updateChildValues(childUpdates)
    }

    func reloadData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Ideas").child(topicName!).observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else { return }
            let newIdea = Idea(ideaName: name, likeCount: likes, key: key)
            var index: Int?
            self.dataSource.enumerated().forEach { (idx, value) in
                if value.key == key {
                    index = idx
                }
            }
            guard let idx = index else { return }
            self.dataSource[idx] = newIdea
            self.dataSourceChanged?()
        })
    }
}
