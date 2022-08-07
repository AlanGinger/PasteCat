//
//  PasteboardEventChannel.swift
//  Runner
//
//  Created by Ju Liaoyuan on 2022/8/7.
//

import Cocoa
import FlutterMacOS

class PasteboardEventChannel: NSObject, FlutterStreamHandler {
    
    var eventChannel: FlutterEventChannel?
    var eventSender: FlutterEventSink?
    
    override init() {
        super.init()
    }
    
    convenience init(messenger: FlutterBinaryMessenger) {
        self.init()
        eventChannel = FlutterEventChannel(name: "com.pastecat/paste", binaryMessenger: messenger)
        eventChannel?.setStreamHandler(self)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSender = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSender = nil
        return nil
    }
    
    func sendData(content: String) -> Bool {
        guard (self.eventSender != nil) else {
            return false
        }
        guard !content.isEmpty else {
            return false
        }
        self.eventSender!(content)
        return true
    }
    
}
