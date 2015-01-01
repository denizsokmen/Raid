//
//  AddProjectViewController.swift
//  Raid
//
//  Created by deniz sokmen on 1/1/15.
//  Copyright (c) 2015 student7. All rights reserved.
//


import UIKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    
    @IBAction func doneClicked(sender: AnyObject) {
        var project = Project(nm: nameLabel.text)
        Database.sharedInstance.projects.append(project)
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}