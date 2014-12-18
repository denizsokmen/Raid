//
//  CellEntry.swift
//  FriendFeedHW
//
//  Created by student7 on 12/11/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation
import UIKit

class CellEntry {
    var name: String
    var body: String
    var image: String
    var date: NSDate
    
    init(name: String, body: String, image: String, date: String) {
        self.name = name
        self.body = body
        self.image = image
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.date = dateFormatter.dateFromString(date)!
        
    }
    
}