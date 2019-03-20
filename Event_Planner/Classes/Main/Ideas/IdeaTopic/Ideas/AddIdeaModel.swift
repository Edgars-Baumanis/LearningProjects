//
//  AddIdeaModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 19.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class AddIdeaModel {
    private var ref: DatabaseReference?
    private var spaceName: String?
    private var topicName: String?
    var ideaAdded: (() -> Void)?

    init(spaceName: String?, topicName: String?) {
        ref = Database.database().reference()
        self.spaceName = spaceName
        self.topicName = topicName
    }
    func addIdea(ideaName: String?) {
        guard ideaName?.isEmpty != true else { return }
        let newIdea = Idea(ideaName: ideaName!, likeCount: 0, key: nil)
        ref?.child("Spaces").child(spaceName!).child("Ideas").child(topicName!).childByAutoId().setValue(newIdea.sendData())
        ideaAdded?()
    }
}
