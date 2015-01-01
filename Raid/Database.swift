//
//  Database.swift
//  Raid
//
//  Created by deniz sokmen on 1/1/15.
//  Copyright (c) 2015 student7. All rights reserved.
// Singleton for swift,

import Foundation

class Database {
    class var sharedInstance: Database {
        struct Static {
            static var instance: Database?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Database()
        }
        return Static.instance!
    }
    
    var users: [User] = []
    var projects: [Project] = []
    
    
}