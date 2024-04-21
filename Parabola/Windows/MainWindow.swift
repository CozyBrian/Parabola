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
            contentRect: NSRect(x: (screen.width / 2) - (1330 / 2), y: (screen.height / 2) - (792 / 2), width: 1330, height: 792),
            styleMask: [.borderless,.fullSizeContentView,.titled,.resizable,.miniaturizable,.closable],
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
    }
    
    
    override var canBecomeKey: Bool {
        return true
    }
}
