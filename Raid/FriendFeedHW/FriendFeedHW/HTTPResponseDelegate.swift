//
//  HTTPResponseDelegate.swift
//  FriendFeedHW
//
//  Created by student7 on 19/11/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation


protocol HTTPResponseDelegate {
    func responseJSON(response:JSON)
}