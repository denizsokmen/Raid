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
    var filteredBugs: [BugReport]!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        refresh()
    }
    
    func refresh() {
        filteredBugs = []
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            for bug in project.bugs {
                if (bug.solved == false) {
                    filteredBugs.append(bug)
                }
            }
            project.bugs.sort({$0.priority > $1.priority})
        }
        
        if (segmentedControl.selectedSegmentIndex == 1) {
            for bug in project.bugs {
                if (bug.solved != false) {
                    filteredBugs.append(bug)
                }
            }
            project.bugs.sort({$0.priority > $1.priority})
        }
        
        if (segmentedControl.selectedSegmentIndex == 2) {
            for bug in project.bugs {
                if (bug.assignee == Database.sharedInstance.currentUser.id) {
                    filteredBugs.append(bug)
                }
            }
            project.bugs.sort({$0.priority > $1.priority})
        }
        
        if (segmentedControl.selectedSegmentIndex == 3) {
            for bug in project.bugs {
                if (bug.assigner == Database.sharedInstance.currentUser.id) {
                    filteredBugs.append(bug)
                }
            }
            project.bugs.sort({$0.priority > $1.priority})
        }
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBugs.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let deptIndex = indexPath.section
        let memberIndex = indexPath.item
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as BugCell
        let bug = filteredBugs[memberIndex]
        cell.title.text = bug.title
        let title = project.name.uppercaseString.substringToIndex(advance(project.name.uppercaseString.startIndex, 3))
        cell.bugid.text = title + "-" + String(bug.id)
        cell.assignee.text = "Assignee: " + Database.sharedInstance.findUser(bug.assignee).name
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
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showbug") {
            let cell = sender as BugCell
            let indexPath = tableView.indexPathForCell(cell)
            let bug = filteredBugs[indexPath!.item]
            let memberVC = segue.destinationViewController as SingleBugViewController
            memberVC.bug = bug
            
        }
    }
    
    
    @IBAction func projectsClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

