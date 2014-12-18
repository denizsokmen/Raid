//
//  NetworkManager.swift
//  Raid
//
//  Created by student7 on 18/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation


class NetworkManager {
    
    init() {
        let addr = "127.0.0.1"
        let port = 9999
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        inputStream.open()
        outputStream.open()
        
        /*var readByte :UInt8 = 0
        while inputStream.hasBytesAvailable {
            inputStream.read(&readByte, maxLength: 1)
        }*/
        
        let buffer:[UInt8] = [0x64, 0x65]
        outputStream.write(buffer, maxLength: buffer.count)
    }
}

