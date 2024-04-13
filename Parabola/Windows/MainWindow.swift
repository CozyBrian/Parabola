//
//  MainWindow.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI
import AppKit

class MainWindow: NSWindow {
    init() {
        let mainScreen = NSScreen.screens[0]
        let screen = mainScreen.frame.size
        
        super.init(
            contentRect: NSRect(x: (screen.width / 2) - (1200 / 2), y: (screen.height / 2) - (792 / 2), width: 1200, height: 792),
            styleMask: [.fullSizeContentView,.titled,.resizable,.closable],
            backing: .buffered,
            defer: false
        )
        
        self.level = .normal
        self.backgroundColor = .clear
        
        let customToolbar = NSToolbar()
        customToolbar.showsBaselineSeparator = false
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden
        self.toolbar = customToolbar
        self.toolbarStyle = .unified
        

//        self.standardWindowButton(.closeButton)?.isHidden = true
//        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
//        self.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    
    override var canBecomeKey: Bool {
        return true
    }
}
