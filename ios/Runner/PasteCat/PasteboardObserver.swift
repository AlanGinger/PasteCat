//
//  PasteboardObserver.swift
//  Runner
//
//  Created by Ju Liaoyuan on 2022/8/7.
//

import UIKit

class PasteboardObserver: NSObject {
    
    var onPasteboardUpdate: ((_ content: String) -> Void)?
    
    private let pasteboard = UIPasteboard.general
    private var changeCount: Int
    
    override init() {
        changeCount = pasteboard.changeCount
        super.init()
        addObserver()
    }
    
    private func addObserver() {
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(onPasteboardChanged), name: UIPasteboard.changedNotification, object: nil)
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(checkPasteboard), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func checkPasteboard() {
        if pasteboard.changeCount != changeCount {
            changeCount = pasteboard.changeCount
            if let content = pasteboard.string {
                syncPasteboardContent(content: content)
            }
        }
    }
    
    @objc private func onPasteboardChanged() {
        if let content = pasteboard.string {
            syncPasteboardContent(content: content)
        }
    }
    
    private func syncPasteboardContent(content: String) {
        guard !content.isEmpty else {
            return
        }
        onPasteboardUpdate?(content)
    }
}
