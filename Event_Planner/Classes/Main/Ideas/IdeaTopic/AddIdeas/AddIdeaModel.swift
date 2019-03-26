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
    private var spaceKey: String?
    private var topicName: IdeaTopicStruct?
    
    var ideaAdded: (() -> Void)?

    init(spaceKey: String?, topicName: IdeaTopicStruct?) {
        ref = Database.database().reference()
        self.spaceKey = spaceKey
        self.topicName = topicName
    }

    func addIdea(ideaName: String?) {
        guard ideaName?.isEmpty != true else { return }
        let newIdea = Idea(ideaName: ideaName!, likeCount: 0, likedPeople: [""], key: nil)
        ref?.child("Spaces").child(spaceKey!).child("Ideas").child((topicName?.key)!).childByAutoId().setValue(newIdea.sendData())
        ideaAdded?()
    }
}
