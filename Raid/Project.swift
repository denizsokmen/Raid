//
//  Project.swift
//  Raid
//
//  Created by student7 on 30/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation

class Project {
    var bugcounter: Int = 0
    var bugs: [BugReport]!
    var users: [User]!
    var name: String!
    
    init(nm : String) {
        bugs = []
        users = []
        name = nm
    }
    
    func addBug(title: String, priority : Int, desc: String) {
        var bug = BugReport(nm: title, prio: priority)
        bug.id = bugcounter++
        bug.description = desc
        bugs.append(bug)
    }
    
}

