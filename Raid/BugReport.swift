//
//  BugReport.swift
//  Raid
//
//  Created by student7 on 30/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation

class BugReport {
    var description: String!
    var title: String!
    var priority: Int!
    var solved: Bool!
    var id: Int!
    var assignee: Int!
    var assigner: Int!
    
    init(nm : String, prio: Int) {
        title = nm
        priority = prio
        id = 1
        solved = false
    }
    
    init(dict : [String:AnyObject]) {
        self.description = dict["desc"] as String
        self.title = dict["title"] as String
        self.priority = dict["priority"] as Int
        self.id = dict["id"] as Int
        self.solved = dict["solved"] as Bool
        self.assignee = dict["assignee"] as Int
        self.assigner = dict["assigner"] as Int
    }
    
    func convertToDict() -> [String: AnyObject] {
        
        var dict : [String: AnyObject] = ["desc": self.description, "title": self.title, "solved": self.solved, "id": self.id, "priority": self.priority, "assignee": self.assignee, "assigner": self.assigner]
        
        return dict
    }
    
}

