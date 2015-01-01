//
//  ViewController.swift
//  Raid
//
//  Created by student7 on 17/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var net: NetworkManager!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        net = NetworkManager()
        net.connect()
        net.send("asdsadd")
    }
    @IBAction func loginClicked(sender: AnyObject) {
        mainSegue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "register" {
            
            let vc = segue.destinationViewController as RegisterViewController
            vc.net = self.net
        }
    }
    
    func mainSegue() {
        if Database.sharedInstance.auth(username.text, pass: password.text) {
            let main = self.storyboard?.instantiateViewControllerWithIdentifier("Main") as UINavigationController
            self.presentViewController(main, animated: true, completion: nil)
            
        }
    }


}

