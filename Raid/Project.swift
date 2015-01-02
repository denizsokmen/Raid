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
    var users: [Int]!
    var name: String!
    
    init(nm : String) {
        bugs = []
        users = []
        name = nm
    }
    
    init(dict: [String:AnyObject]) {
        bugs = []
        users = []
        let nm: AnyObject? = dict["name"]
        let bugc: AnyObject? = dict["bugcounter"]
        let memberDict: AnyObject? = dict["users"]
        let bugDict = dict["bugs"] as [[String:AnyObject]]
        
        name = nm as String
        bugcounter = bugc as Int
        
        
        for i in memberDict as [Int] {
            users.append(i)
        }
        
        for i in bugDict {
            let bug = BugReport(dict: i)
            bugs.append(bug)
        }
    }
    
    func addBug(title: String, priority : Int, desc: String) {
        var bug = BugReport(nm: title, prio: priority)
        bug.id = bugcounter++
        bug.description = desc
        bugs.append(bug)
    }
    
    
    func convertToDict() -> [String: AnyObject] {
        var bugsArray = [[String:AnyObject]]()
        for bug in bugs {
            bugsArray.append(bug.convertToDict())
        }
        
        var dict : [String: AnyObject] = ["name": self.name, "bugcounter": self.bugcounter, "bugs": bugsArray, "users": self.users]
        
        return dict
    }
    
}

