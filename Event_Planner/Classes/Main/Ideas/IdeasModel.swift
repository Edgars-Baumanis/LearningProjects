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
    var cellPressed: ((_ cellName: String) -> Void)?
    var dataSourceChanged: (() -> Void)?
    var dataSource: [String] = []
    private var ref: DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private var spaceName: String?
    init(spaceName: String?) {
        self.spaceName = spaceName
        ref = Database.database().reference()
        databaseHandle = DatabaseHandle()
    }

    func getTopics() {
        databaseHandle = ref?.child("Spaces").child(spaceName!).child("Ideas").observe(.childAdded, with: { (snapshot) in
            guard let topicName = snapshot.key as? String else { return }
            self.dataSource.append(topicName)
            self.dataSourceChanged?()
        })
    }
}
