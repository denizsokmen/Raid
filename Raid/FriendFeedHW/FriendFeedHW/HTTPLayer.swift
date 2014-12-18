//
//  HTTPLayer.swift
//  FriendFeedHW
//
//  Created by student7 on 19/11/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation


class HTTPLayer {
    var responseDelegate:HTTPResponseDelegate
    
    init(responseDelegate:HTTPResponseDelegate){
        self.responseDelegate = responseDelegate
    }
    
    func invokeGet(url: String) {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            if let nsurl = NSURL(string: url) {
                if let nsdata = NSData(contentsOfURL: nsurl) {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.requestDidFinish(nsdata)
                    })
                }
            }
        })
    }
    
    func requestDidFinish(response:NSData) {
        var body : NSString = NSString(data: response, encoding: NSUTF8StringEncoding)!
        var json = JSON.parse(body)
        responseDelegate.responseJSON(json)
    }
}
