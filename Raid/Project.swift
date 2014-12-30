//
//  Project.swift
//  Raid
//
//  Created by student7 on 30/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation

class Project {
    var bugs: [BugReport]!
    var name: String!
    
    init(nm : String) {
        bugs = []
        name = nm
    }
    
}

