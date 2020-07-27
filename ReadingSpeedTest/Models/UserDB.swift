//
//  UserDB.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/26/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation
import UIKit

class UserDB
{
    var users: Array<User>
    
    init() {
        users = Array<User>()
    }
    
    func getUser(_ index: Int) -> User {
        return users[index]
    }
    
    func sortBySpeed() {
        users.sort(by: { $0.topSpeed > $1.topSpeed })
    }
    
    func createNewUser(_ username: String) {
        users.append(User(username))
        archive()
        setCurrentUser(users[users.count - 1])
    }
    
    func setCurrentUser(_ user: User) {
        let defaults = UserDefaults.standard
        defaults.setValuesForKeys(["username": user.username, "latesttries": user.latestTries, "topspeed": user.topSpeed, "defaultspeed": user.defaultSpeed, "startingdelay": user.startingDelay, "totaltries": user.totalTries])
    }
    
    func archive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        NSKeyedArchiver.archiveRootObject(users, toFile: path)
    }
    
    func unarchive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            users = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! [User]
        }
    }
 /*
    @objc func archive(notification: Notification) {
        let path = NSHomeDirectory() + "/Documents/usersNotification.archive"
        NSKeyedArchiver.archiveRootObject(users, toFile: path)
    }

    @objc func unarchive(notification: Notification) {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            users = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! [User]
        }
    }*/
}
