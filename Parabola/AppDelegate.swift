//
//  AppDelegate.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import Cocoa
import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var mainWindow: MainWindow = MainWindow()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMain()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func setupMain() {
        var windowPositionCenter: CGPoint {
            let mainScreen = NSScreen.screens[0]
            let screen = mainScreen.frame.size
            
            return .init(x: (screen.width / 2) - (1200 / 2), y: (screen.height / 2) - (792 / 2))
        }
        
        setupMainWindow(
            size: NSSize(width: 1200, height: 792),
            position: windowPositionCenter,
            view: ContentView(parentWindow: mainWindow)
        )
        
        mainWindow.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    
    func setupMainWindow<Content: View>(size: NSSize, position: CGPoint, view: Content) {
        DispatchQueue.main.async {
            self.mainWindow.setFrame(NSRect(origin: position, size: size), display: true, animate: true)
        }
        
        let rootView = view.edgesIgnoringSafeArea(.top)
        let hostedOnboardingView = NSHostingView(rootView: rootView)
        mainWindow.contentView = hostedOnboardingView
    }

}
