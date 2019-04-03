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


    func getSpaces(completionHandler: @escaping ([[SpaceDO]]) -> Void) {
        var allSpaces: [[SpaceDO]] = [[],[]]
        spaceRoute?.observe(.childAdded, with: { (snapshot) in
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
            let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser)
            if isValid {
                if mainUser == Dependencies.instance.userService.user?.userID {
                    allSpaces[0].append(newSpace)
                    completionHandler(allSpaces)
                } else {
                    allSpaces[1].append(newSpace)
                    completionHandler(allSpaces)
                }
            } else {
                return
            }
        })
    }
    func reloadSpaces(completionHandler: @escaping (SpaceDO, Int) -> Void) {
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
            let newSpace = SpaceDO(spaceName: spaceName, spacePassword: nil, spaceDescription: spaceDesc, users: newUsers, key: key, mainUser: mainUser)
            if isValid {
                if mainUser == Dependencies.instance.userService.user?.userID {
                    completionHandler(newSpace, 0)
                } else {
                    completionHandler(newSpace, 1)
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
        let newSpace = SpaceDO(spaceName: name!, spacePassword: password!, spaceDescription: description!, users: users, key: nil, mainUser: userID)
        spaceRoute?.childByAutoId().setValue(newSpace.sendData())
        completionHandler(nil)
    }

    func joinSpace(enteredSpaceName: String?, enteredSpacePassword: String?, completionHandler: @escaping (SpaceDO?, String?) -> Void) {
        guard enteredSpaceName?.isEmpty != true, enteredSpacePassword?.isEmpty != true else {
            completionHandler(nil, "Please enter Space name and/or Space password")
            return
        }
        spaceRoute?.observe(.childAdded, with: { [weak self] (snapshot) in
            let post = snapshot.value as? [String : Any]
            guard
                let spaceName = post?["name"] as? String,
                let spacePassword = post?["password"] as? String,
                let spaceDescription = post?["description"] as? String,
                var users = post?["users"] as? [String],
                let mainUser = post?["mainUser"] as? String,
                let key = snapshot.key as? String
                else { return }
            guard spaceName == enteredSpaceName, spacePassword == enteredSpacePassword else {
                return
            }
            var isValid = false
            users.forEach { (value) in
                value == Dependencies.instance.userService.user?.userID ||
                    mainUser == Dependencies.instance.userService.user?.userID ?
                    isValid = true : nil
            }
            if isValid {
                completionHandler(nil, "Can't join a space you are already a part of")
                return
            } else {
                guard let userID = Dependencies.instance.userService.user?.userID else { return }
                users.append(userID)
                let newSpace = SpaceDO(spaceName: spaceName, spacePassword: spacePassword, spaceDescription: spaceDescription, users: users, key: nil, mainUser: mainUser)
                let childUpdate = [
                    "/Spaces/\(key)/" : newSpace.sendData()
                ]
                self?.ref.updateChildValues(childUpdate)
                completionHandler(newSpace, nil)
                return
            }
        })
    }
}
