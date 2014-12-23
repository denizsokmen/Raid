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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let deptIndex = indexPath.section
        let memberIndex = indexPath.item
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as BugCell
        cell.title.text = "Hob"
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reported Bugs"
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

