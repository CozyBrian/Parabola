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
    
    init() {
        @AppStorage("appColor") var appSettingsAppColor: String = "#068EF5"
        self.appColor = Color(hex: appSettingsAppColor)
    }
    
    func setAppColor(_ color: Color) {
        @AppStorage("appColor") var appSettingsAppColor: String = "#068EF5"
        appSettingsAppColor = color.toHex()
    }
}
