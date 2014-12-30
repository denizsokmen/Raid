//
//  ProjectViewController.swift
//  Raid
//
//  Created by student7 on 24/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

//
//  BugViewController.swift
//  Raid
//
//  Created by student7 on 23/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var net: NetworkManager!
    var projects: [Project]!
    
    
    @IBOutlet weak var tableView: UITableView!
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let deptIndex = indexPath.section
        let memberIndex = indexPath.item
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as ProjectCell
        let project = projects[memberIndex]
        cell.title.text = project.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let deptIndex = indexPath.section
        let memberIndex = indexPath.item
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
    }
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projects = []
        let project = Project(nm:"wow")
        project.bugs.append(BugReport(nm:"Patlıyor", prio: 4))
        project.bugs.append(BugReport(nm:"Hatalı", prio: 2))
        project.bugs.append(BugReport(nm:"Wow", prio: 3))
        project.bugs.append(BugReport(nm:"hoo", prio: 5))
        projects.append(project)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "project") {
            let cell = sender as ProjectCell
            let indexPath = tableView.indexPathForCell(cell)
            let project = projects[indexPath!.item]
            let memberVC = segue.destinationViewController as ProjectTabController
            memberVC.project = project

        }
    }
    
    
    
}

