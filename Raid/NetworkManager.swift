//
//  NetworkManager.swift
//  Raid
//
//  Created by student7 on 18/12/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import Foundation

extension String {
    func length() -> Int {
        return (self as NSString).length
    }
}

class NetworkManager : NSObject, NSStreamDelegate {
    var inputStream: NSInputStream!
    var outputStream: NSOutputStream!
    var buffer: UnsafeMutablePointer<UInt8>!
    var bufferOffset = size_t()
    var bufferLimit = size_t()
 
   
    
    func connect() {
        buffer = UnsafeMutablePointer<UInt8>.alloc(100)
        buffer[0] = 2
        let addr = "127.0.0.1"
        let port = 9999
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        self.inputStream = inp!
        self.outputStream = out!
        self.inputStream.delegate = self;
        self.outputStream.delegate = self;
        
        self.inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.inputStream.open()
        self.outputStream.open()
        
        /*var readByte :UInt8 = 0
        while inputStream.hasBytesAvailable {
            inputStream.read(&readByte, maxLength: 1)
        }*/
        
        //let buffer:[UInt8] = [0x64, 0x65]
        //outputStream.write(buffer, maxLength: buffer.count)
        let buff:[UInt8] = [0x0, 0x3, 0x64, 0x65, 0x50]
        let buf = NSString(CString: "asd", encoding: NSASCIIStringEncoding)
        
        outputStream.write(buff, maxLength: buff.count)
    }
    
    func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch(eventCode) {
        case NSStreamEvent.HasBytesAvailable:
            println("Something received")
            break;
     
            
        case NSStreamEvent.OpenCompleted:
            println("Connection complete")
            
        default:
            println(eventCode.rawValue)
        }
    }
    
    func send(text: String) {
        var data = UInt16(text.utf16Count).bigEndian
        var str : String = ""
        
        str.append(Character(UnicodeScalar(Int(data & 0x00ff))))
        str.append(Character(UnicodeScalar(Int((data & 0xff00) >> 8))))
        str += text
        
        var unsafedata = NSData(data: str.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)!)
        self.outputStream.write(UnsafePointer(unsafedata.bytes), maxLength: unsafedata.length)
        
        
        
    }
    
    
}

