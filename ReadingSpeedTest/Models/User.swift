//
//  User.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding
{
    // This class holds the necessary data for a user.
    var username: String
    var latestTries = Array<Int>()
    var topSpeed: Int
    var defaultSpeed: Int
    var startingDelay: Int
    var totalTries: Int
    
    init(_ username: String) {
        self.username = username
        latestTries = [0, 0, 0]
        topSpeed = 0
        defaultSpeed = 60
        startingDelay = 1
        totalTries = 0
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(username, forKey: "username")
        encoder.encode(latestTries, forKey: "latesttries")
        encoder.encode(topSpeed, forKey: "topspeed")
        encoder.encode(defaultSpeed, forKey: "defaultspeed")
        encoder.encode(startingDelay, forKey: "startingdelay")
        encoder.encode(totalTries, forKey: "totaltries")
    }
    
    required init?(coder decoder: NSCoder) {
        username = decoder.decodeObject(forKey: "username") as! String
        latestTries = decoder.decodeObject(forKey: "latesttries") as! Array<Int>
        topSpeed = decoder.decodeObject(forKey: "topspeed") as! Int
        defaultSpeed = decoder.decodeObject(forKey: "defaultspeed") as! Int
        startingDelay = decoder.decodeObject(forKey: "startingdelay") as! Int
        totalTries = decoder.decodeObject(forKey: "totaltries") as! Int
    }
}
