//
//  AddMemberViewController.swift
//  Raid
//
//  Created by deniz sokmen on 1/3/15.
//  Copyright (c) 2015 student7. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var project: Project!
    var members: [Int]!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func addMember(sender: AnyObject) {
        project.users.append(members[picker.selectedRowInComponent(0)])
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        members = []
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func refresh() {
        members = []
        for user1 in Database.sharedInstance.users {
            var found: Bool = false
            for user in project.users {
                if user == user1.id {
                    found = true
                }
            }
            
            if found == false {
                members.append(user1.id)
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return members.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return Database.sharedInstance.findUser(members[row]).name
    }
}