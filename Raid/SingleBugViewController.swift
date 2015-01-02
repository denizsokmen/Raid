//
//  SingleBugViewController.swift
//  Raid
//
//  Created by deniz sokmen on 1/1/15.
//  Copyright (c) 2015 student7. All rights reserved.
//

import UIKit

class SingleBugViewController: UIViewController {
    var bug: BugReport!
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var resolveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let color: CGFloat = CGFloat(bug.priority) / 5.0
        progressBar.progress = Float(color)
        progressBar.progressTintColor = UIColor(red: color, green: 1-color, blue: 0.0, alpha: 1.0)
        priorityLabel.textColor = UIColor(red: color, green: 1-color, blue: 0.0, alpha: 1.0)
        
        if color > 0.7 {
            priorityLabel.text = "HIGH"
        }
        else if color > 0.4 {
            priorityLabel.text = "NORMAL"
        }
        else {
            priorityLabel.text = "LOW"
        }
        
        titleLabel.text = "#" + String(bug.id) + " - " + bug.title
        descriptionText.text = bug.description
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if bug.solved == true {
            priorityLabel.text = "Resolved"
            priorityLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.0, alpha: 1.0)
            progressBar.progress = 1.0
            progressBar.progressTintColor = UIColor(red: 0.2, green: 0.8, blue: 0.0, alpha: 1.0)
            resolveButton.hidden = true
        }
        else {
            resolveButton.hidden = false
        }
        
        Database.sharedInstance.save()
    }
    
    @IBAction func resolve(sender: AnyObject) {
        bug.solved = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

