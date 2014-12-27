//
//  RegisterViewController.swift
//  Raid
//
//  Created by student7 on 23/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {
    
    var net: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerClicked(sender: UIButton) {
        
    }
}
