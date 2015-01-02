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
    var currentUser: User! = nil
    var userCounter: Int = 0
    
    func addUser(user: String, pass: String) {
        let usr = User(user: user, pass: pass)
        usr.id = userCounter++
        users.append(usr)
        
        save()
    }
    
    func addProject(proj: Project) {
        projects.append(proj)
        save()
    }
    
    func findUser(id: Int) -> User! {
        for usr in users {
            if usr.id == id {
                return usr
            }
        }
        return nil
    }
    
    func findUser(name: String) -> User! {
        for usr in users {
            if usr.username == name {
                return usr
            }
        }
        return nil
    }
    
    
    
    func auth(user: String, pass: String) -> Bool{
        for usr in users {
            if usr.username == user && usr.password == pass {
                currentUser = usr
                return true
            }
        }
        
        return false
    }
    
    func convertToDict() -> [String:AnyObject] {
        var projectArray = [[String:AnyObject]]()
        for project in projects {
            projectArray.append(project.convertToDict())
        }
        
        var userArray = [[String:AnyObject]]()
        for user in users {
            userArray.append(user.convertToDict())
        }
        
        let dict = ["projects": projectArray, "users": userArray]
        
        return dict
    }
    
    func createFromDict(dict : [String:AnyObject]) {
        let proj: AnyObject? = dict["projects"]
        
        for i in proj as [[String:AnyObject]] {
            var project = Project(dict: i)
            projects.append(project)
        }
        
        let usr: AnyObject? = dict["users"]
        
        for i in usr as [[String:AnyObject]] {
            var user = User(dict: i)
            users.append(user)
        }
    }
    
    func save() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let dict = convertToDict()
        var data = NSKeyedArchiver.archivedDataWithRootObject(dict)
        userDefaults.setObject(data, forKey: "database")
        userDefaults.synchronize()
    }
    
    func load() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let defaultItems = userDefaults.dataForKey("database")
        let dict = NSKeyedUnarchiver.unarchiveObjectWithData(defaultItems!) as [String:AnyObject]
        
        createFromDict(dict)
    }
    
}