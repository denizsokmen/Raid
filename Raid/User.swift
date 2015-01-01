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
    var id: Int!
    
    init(user: String, pass: String) {
        username = user
        password = pass
    }
    
}