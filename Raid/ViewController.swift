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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        net = NetworkManager()
        net.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

