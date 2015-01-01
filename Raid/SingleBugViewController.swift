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
    
    @IBAction func resolve(sender: AnyObject) {
        //dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

