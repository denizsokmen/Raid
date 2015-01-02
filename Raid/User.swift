//
//  User.swift
//  Raid
//
//  Created by deniz sokmen on 1/1/15.
//  Copyright (c) 2015 student7. All rights reserved.
//

import Foundation

class User {
    var isStaff: Bool = false
    var username: String!
    var password: String!
    var name: String!
    var id: Int!
    
    init(user: String, pass: String) {
        username = user
        password = pass
        name = "asd"
    }
    
    init(dict : [String:AnyObject]) {
        self.name = dict["name"] as String
        self.username = dict["username"] as String
        self.password = dict["password"] as String
        self.id = dict["id"] as Int
        self.isStaff = dict["staff"] as Bool
    }
    
    func convertToDict() -> [String: AnyObject] {
        var dict : [String: AnyObject] = ["username": self.username, "password": self.password, "name": self.name, "id": self.id, "staff": isStaff]
        
        return dict
    }
}