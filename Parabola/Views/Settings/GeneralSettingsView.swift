//
//  GeneralSettingsView.swift
//  Parabola
//
//  Created by Brian Newton on 21/04/2024.
//

import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var globalSettings: GlobalSettings
    
    var body: some View {
        Form {
            Section {
                Toggle("Toggle debug Mode", isOn: $globalSettings.debugMode)
                    .onChange(of: globalSettings.debugMode, { oldV, newV in
                        globalSettings.toggleDebugMode(newV)
                    })
          
                ColorPicker("system Color", selection: $globalSettings.appColor)
                    .onChange(of: globalSettings.appColor, { oldV, newV in
                        globalSettings.setAppColor(newV)
                    })
            }
        }.formStyle(.grouped)
    }
}

#Preview {
    GeneralSettingsView()
}
