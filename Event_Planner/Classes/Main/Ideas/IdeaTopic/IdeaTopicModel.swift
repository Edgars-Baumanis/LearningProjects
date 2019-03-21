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
    private var userServices: PUserService?
    private var likedPeople: [String] = []
    var topicName: IdeaTopicStruct?
    var addPressed: (() -> Void)?
    var dataSource: [Idea] = []
    var dataSourceChanged: (() -> Void)?

    init(topicName: IdeaTopicStruct?, spaceName: String?, userServices: PUserService?) {
        self.userServices = userServices
        self.topicName = topicName
        self.spaceName = spaceName
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
    }

    func getData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Ideas").child((topicName?.key)!).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            let likedPeople = post?["LikedPeople"] as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else { return }
            likedPeople?.forEach { key, value in
                guard let newValue = value as? String else { return }
                self.likedPeople.append(newValue)
            }
            let newIdea = Idea(ideaName: name, likeCount: likes, key: key)

            self.dataSource.append(newIdea)
            self.dataSourceChanged?()
        })
    }

    func addLike(index: Int) {
        guard let userID = userServices?.user?.userID else { return }
        if likedPeople.contains(userID) != true {
            let likedField = dataSource[index]
            let newField = Idea(ideaName: likedField.ideaName, likeCount: likedField.likeCount + 1, key: nil)

            guard let key = likedField.key, let newTopicKey = topicName?.key else { return }
            let childUpdates = [
                "/Spaces/\(spaceName!)/Ideas/\(newTopicKey)/\(key)" : newField.sendData()
            ]
            ref?.updateChildValues(childUpdates)

            ref?.child("Spaces").child(spaceName!).child("Ideas").child((topicName?.key)!).child(key).child("LikedPeople").childByAutoId().setValue(userServices?.user?.userID)
        }
    }

    func reloadData() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Ideas").child((topicName?.key)!).observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            let likedPeople = post?["LikedPeople"] as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let likes = post?["likes"] as? Int,
                let key = snapshot.key as? String
                else { return }
            likedPeople?.forEach { key, value in
                    guard let newValue = value as? String else { return }
                    self.likedPeople.append(newValue)
            }
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
