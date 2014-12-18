//
//  EntryViewController.swift
//  FriendFeedHW
//
//  Created by student7 on 19/11/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    weak var cell : CellEntry?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        webView.loadHTMLString(cell?.body, baseURL: nil)
    }
    
    @IBAction func onClickOK(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
