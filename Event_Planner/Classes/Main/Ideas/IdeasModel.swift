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
    var addTopicPressed: (()-> Void)?
    var cellPressed: ((_ ideaTopic: IdeaTopicStruct?) -> Void)?
    var dataSourceChanged: (() -> Void)?
    var dataSource: [IdeaTopicStruct] = []
    var filteredDataSource: [IdeaTopicStruct]?
    private var ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private var spaceKey: String?
    
    init(spaceKey: String?) {
        self.spaceKey = spaceKey
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
        filteredDataSource = []
    }

    func getTopics() {
        databaseHandle = ref?.child("Spaces").child(spaceKey!).child("Ideas").observe(.childAdded, with: { (snapshot) in
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
