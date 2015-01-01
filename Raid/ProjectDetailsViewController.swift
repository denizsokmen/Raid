//
//  ProjectDetailsViewController.swift
//  Raid
//
//  Created by deniz sokmen on 1/1/15.
//  Copyright (c) 2015 student7. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {
    var project: Project!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var bugsLabel: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var developers: UILabel!
    
    @IBAction func addMember(sender: AnyObject) {
    }
    
    @IBAction func leaveProject(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = self.tabBarController as ProjectTabController
        self.project = controller.project
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        developers.text = String(project.users.count)
        projectName.text = project.name
        
        if project.bugs.count == 0 {
            progressBar.progress = 0.0
            bugsLabel.text = "0"
        }
        else {
            var numSolved: Int = 0
            for bug in project.bugs {
                if bug.solved == true {
                    numSolved++
                }
            }
            
            progressBar.progress = Float(numSolved) / Float(project.bugs.count)
            bugsLabel.text = String(numSolved) + "/" + String(project.bugs.count)
        }
    }
}