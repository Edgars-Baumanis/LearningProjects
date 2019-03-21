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
    private var spaceName: String?
    var addTopicPressed: (() -> Void)?


    init(spaceName: String?) {
        self.spaceName = spaceName
        ref = Database.database().reference()
    }

    func addTopic(topicName: String?) {
        guard topicName?.isEmpty != true else { return }
        let newTopic = IdeaTopicStruct(name: topicName!, key: nil)
        ref?.child("Spaces").child(spaceName!).child("Ideas").childByAutoId().setValue(newTopic.sendData())
        self.addTopicPressed?()
    }
}
