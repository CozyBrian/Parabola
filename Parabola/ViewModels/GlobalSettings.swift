//
//  GlobalSettings.swift
//  Parabola
//
//  Created by Brian Newton on 20/04/2024.
//

import Foundation
import SwiftUI

class GlobalSettings: ObservableObject {
    @Published var showUrlBarOverlay: Bool = false
    @Published var showCommand: Bool = false
    @Published var appColor: Color = Color(hex: "#8EAFD2")
    @Published var debugMode: Bool = false
    
    init() {
        @AppStorage("debugMode") var appSettingsDebugMode: Bool = false
        @AppStorage("appColor") var appSettingsAppColor: String = "#068EF5"
        self.debugMode = appSettingsDebugMode
        self.appColor = Color(hex: appSettingsAppColor)
    }
    
    func setAppColor(_ color: Color) {
        @AppStorage("appColor") var appSettingsAppColor: String = "#068EF5"
        appSettingsAppColor = color.toHex()
    }
    
    func toggleDebugMode(_ bool: Bool) {
        self.debugMode = bool
        @AppStorage("debugMode") var appSettingsDebugMode: Bool = bool
    }
}
