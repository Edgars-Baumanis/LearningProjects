//
//  SpaceDO.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 27.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

struct SpaceDO {
    let spaceName: String
    let spacePassword: String?
    let spaceDescription: String
    var users: [String]
    var key: String?
    let mainUser: String
    let chats: AnyObject?
    let budget: AnyObject?
    let ideas: AnyObject?
    let tasks: AnyObject?

    init (spaceName: String, spacePassword: String?, spaceDescription: String, users: [String], key: String?, mainUser: String,chats: AnyObject?, budget: AnyObject?, ideas: AnyObject?, tasks: AnyObject?) {
        self.spaceName = spaceName
        self.spacePassword = spacePassword
        self.spaceDescription = spaceDescription
        self.users = users
        self.key = key
        self.mainUser = mainUser
        self.chats = chats
        self.budget = budget
        self.ideas = ideas
        self.tasks = tasks
    }

    func sendData() -> Any {
        return [
            "name": spaceName,
            "password": spacePassword,
            "description": spaceDescription,
            "users": users,
            "mainUser": mainUser,
            "Chats" : chats,
            "Budget": budget,
            "Ideas": ideas,
            "Tasks": tasks
        ]
    }
}
