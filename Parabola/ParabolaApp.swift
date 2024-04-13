//
//  ParabolaApp.swift
//  Parabola
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

@main
struct ParabolaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
