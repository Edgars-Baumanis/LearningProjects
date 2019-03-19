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
    var ref: DatabaseReference?
    var addTopicPressed: (() -> Void)?
    private var spaceName: String?

    init(spaceName: String?) {
        self.spaceName = spaceName
        ref = Database.database().reference()
    }

    func addTopic(topicName: String?) {
        guard topicName?.isEmpty != true else { return }
        ref?.child("Spaces").child(spaceName!).child("Ideas").child(topicName!).setValue(topicName)
        self.addTopicPressed?()
    }
}
