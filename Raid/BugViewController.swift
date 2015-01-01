//
//  BugViewController.swift
//  Raid
//
//  Created by student7 on 23/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class BugViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var net: NetworkManager!
    var project: Project!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 1) {
            project.bugs.sort({$0.priority > $1.priority})
            tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.bugs.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let deptIndex = indexPath.section
        let memberIndex = indexPath.item
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as BugCell
        let bug = project.bugs[memberIndex]
        cell.title.text = bug.title
        cell.bugid.text = "SOC-1"
        cell.assignee.text = "Hakan Taşıyan"
        let color: CGFloat = CGFloat(bug.priority) / 5.0
        println(color)
        
        cell.backgroundColor = UIColor(red: color, green: 1-color, blue: 0.0, alpha: 1.0)
        
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
        
        let controller = self.tabBarController as ProjectTabController
        self.project = controller.project
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func projectsClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

