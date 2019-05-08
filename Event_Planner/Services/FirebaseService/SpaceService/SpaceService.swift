//
//  SpaceService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation
import Firebase

class SpaceService: PSpacesService {

    private let spacesString = "Spaces"
    private let ref = Database.database().reference()
    private var spaceRoute: DatabaseReference?

    init() {
        spaceRoute = ref.child(spacesString)
    }


    func getSpaces(completionHandler: @escaping ([SpaceDO]) -> Void) {
        var allSpaces: [SpaceDO] = []
        spaceRoute?.observeSingleEvent(of: .value, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            post?.forEach({ (key, value) in
                let singleSpace = value as? [String : AnyObject]
                guard
                    let spaceName = singleSpace?["name"] as? String,
                    let users = singleSpace?["users"] as? [String],
                    let spaceDesc = singleSpace?["description"] as? String,
                    let key = key as? String,
                    let mainUser = singleSpace?["mainUser"] as? String
                    else { return }

                var isValid = false
                var newUsers: [String] = []
                users.forEach { (value) in
                    value == Dependencies.instance.userService.user?.userID ? isValid = true : nil
                    newUsers.append(value)
                }
                if isValid {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    allSpaces.append(newSpace)
                    completionHandler(allSpaces)

                } else {
                    return
                }
            })
        })
    }

    func getAllSpaces(completionHandler: @escaping ([SpaceDO]) -> Void) {
        var allSpaces: [SpaceDO] = []
        spaceRoute?.observeSingleEvent(of: .value, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            post?.forEach({ (key, value) in
                let singleSpace = value as? [String : AnyObject]
                guard
                    let spaceName = singleSpace?["name"] as? String,
                    let users = singleSpace?["users"] as? [String],
                    let spaceDesc = singleSpace?["description"] as? String,
                    let key = key as? String,
                    let mainUser = singleSpace?["mainUser"] as? String,
                    let spacePassword = singleSpace?["password"] as? String
                    else { return }

                var isValid = false
                users.forEach({ (userID) in
                    userID == Dependencies.instance.userService.user?.userID ? isValid = true : nil
                })
                if !isValid {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: spacePassword, spaceDescription: spaceDesc, users: users, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    allSpaces.append(newSpace)
                    completionHandler(allSpaces)
                } else { return }
            })
        })
    }

    func reloadSpaces(completionHandler: @escaping (SpaceDO) -> Void) {
        spaceRoute?.observe(.childChanged, with: { (snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let spaceName = post?["name"] as? String,
                let users = post?["users"] as? [String],
                let spaceDesc = post?["description"] as? String,
                let key = snapshot.key as? String,
                let mainUser = post?["mainUser"] as? String
                else { return }
            var isValid = false
            var newUsers: [String] = []
            users.forEach { (value) in
                value == Dependencies.instance.userService.user?.userID ? isValid = true : nil
                newUsers.append(value)
            }

            if isValid {
                if mainUser == Dependencies.instance.userService.user?.userID {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    completionHandler(newSpace)
                } else {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    completionHandler(newSpace)
                }
            } else {
                return
            }
        })
        spaceRoute?.observe(.childAdded, with: {(snapshot) in
            let post = snapshot.value as? [String : AnyObject]
            guard
                let spaceName = post?["name"] as? String,
                let users = post?["users"] as? [String],
                let spaceDesc = post?["description"] as? String,
                let key = snapshot.key as? String,
                let mainUser = post?["mainUser"] as? String
                else { return }
            var isValid = false
            var newUsers: [String] = []
            users.forEach { (value) in
                value == Dependencies.instance.userService.user?.userID ? isValid = true : nil
                newUsers.append(value)
            }

            if isValid {
                if mainUser == Dependencies.instance.userService.user?.userID {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    completionHandler(newSpace)
                } else {
                    let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser, chats: nil, budget: nil, ideas: nil, tasks: nil)
                    completionHandler(newSpace)
                }
            } else {
                return
            }
        })
    }

    func createSpace(name: String?, password: String?, description: String?, completionHandler: (String?) -> Void) {
        guard name?.isEmpty != true, password?.isEmpty != true, description?.isEmpty != true else {
            completionHandler("Please enter Space name and/or Space password and/or Space description")
            return
        }
        var users: [String] = []
        guard let userID = Dependencies.instance.userService.user?.userID else {return}
        users.append(userID)
        let newSpace = SpaceDO(spaceName: name!, spacePassword: password!, spaceDescription: description!, users: users, key: nil, mainUser: userID, chats: nil, budget: nil, ideas: nil, tasks: nil)
        spaceRoute?.childByAutoId().setValue(newSpace.sendData())
        completionHandler(nil)
    }

    func joinSpace(space: SpaceDO?, completionHandler: @escaping (SpaceDO?, String?) -> Void) {
        guard let space = space else {
            completionHandler(nil, "Problem with space info")
            return
        }
        var newSpace = space
        newSpace.key = nil
        var isValid = false
        newSpace.users.forEach { (value) in
            value == Dependencies.instance.userService.user?.userID ||
                newSpace.mainUser == Dependencies.instance.userService.user?.userID ?
                    isValid = true : nil
        }
        if isValid {
            completionHandler(nil, "Can't join a space you are already a part of")
            return
        } else {
            guard let userID = Dependencies.instance.userService.user?.userID else { return }
            newSpace.users.append(userID)
            guard let key = space.key else { return }
            let childUpdate = [
                "/Spaces/\(key)/" : newSpace.sendData()
            ]
            ref.updateChildValues(childUpdate)
            completionHandler(newSpace, nil)
            return
        }
    }
}
