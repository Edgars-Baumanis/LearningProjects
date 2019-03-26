//
//  IdeasModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit
import Firebase

class IdeasModel {

    private var ref: DatabaseReference?
    private var spaceKey: String?
    
    var navigateToAddTopic: (()-> Void)?
    var navigateToIdea: ((_ ideaTopic: IdeaTopicStruct?) -> Void)?
    var dataSourceChanged: (() -> Void)?
    var dataSource: [IdeaTopicStruct] = []
    var filteredDataSource: [IdeaTopicStruct]?
    
    init(spaceKey: String?) {
        self.spaceKey = spaceKey
        ref = Database.database().reference()
        filteredDataSource = []
    }

    func getTopics() {
        ref?.child("Spaces").child(spaceKey!).child("Ideas").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let name = post?["name"] as? String,
                let key = snapshot.key as? String
                else { return }
            let newTopic = IdeaTopicStruct(name: name, key: key)
            self.dataSource.append(newTopic)
            self.filteredDataSource?.append(newTopic)
            self.dataSourceChanged?()
        })
    }
}
