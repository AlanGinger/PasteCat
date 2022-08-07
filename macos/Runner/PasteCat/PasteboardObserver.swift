//
//  PasteboardObserver.swift
//  Runner
//
//  Created by Ju Liaoyuan on 2022/8/7.
//

import Cocoa

class PasteboardObserver: NSObject {
    private let pasteboard = NSPasteboard.general
    private let timerInterval = 0.5
    
    private var changeCount: Int
    var timer: Timer?
    var onPasteboardUpdate: ((_ content: String) -> Void)?
    
    override init() {
        changeCount = pasteboard.changeCount
        super.init()
    }
    
    func start() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(onPasteboardChanged), userInfo: nil, repeats: true)
    }
    
    func end() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func onPasteboardChanged() {
        guard pasteboard.changeCount != changeCount else {
            return
        }
        
        changeCount = pasteboard.changeCount
        
        if let content = pasteboard.string(forType: NSPasteboard.PasteboardType.string) {
            onPasteboardUpdate?(content)
        }
    }
}
