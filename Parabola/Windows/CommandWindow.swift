//
//  CommandWindow.swift
//  Parabola
//
//  Created by Brian Newton on 15/04/2024.
//

import AppKit

class CommandWindow: NSWindow {
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 300),
            styleMask: [.titled, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.titlebarAppearsTransparent = true
        self.isMovableByWindowBackground = true
        self.isReleasedWhenClosed = true
        self.level = .floating
    }
    
    override var canBecomeKey: Bool {
        return true
    }
}
