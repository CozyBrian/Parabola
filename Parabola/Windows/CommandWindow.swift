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
            styleMask: [.borderless, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.titlebarAppearsTransparent = true
        self.isMovableByWindowBackground = true
        self.isReleasedWhenClosed = true
        self.level = .floating
        self.backgroundColor = .clear
    }
    
    func updatePosition(_ to: CGPoint) {
//        self.setFrameOrigin(to)
        let fittingSize = contentView?.fittingSize ?? .zero
        self.setFrame(.init(origin: to, size: fittingSize), display: true, animate: false)
    }
    
    override var canBecomeKey: Bool {
        return true
    }
    
    func centerWindow(in targetWindow: NSWindow) {
        guard let targetWindowFrame = targetWindow.contentView?.frame,
              let windowToCenterFrame = self.contentView?.frame else {
            return
        }
        
        let targetWindowCenter = NSPoint(x: targetWindowFrame.origin.x + targetWindowFrame.size.width / 2,
                                         y: targetWindowFrame.origin.y + targetWindowFrame.size.height / 2)
        
        let newOrigin = NSPoint(x: targetWindowCenter.x - windowToCenterFrame.size.width / 2,
                                y: targetWindowCenter.y - windowToCenterFrame.size.height / 2)
        
        self.setFrameOrigin(newOrigin)
    }

}
