//
//  SettingsView.swift
//  Parabola
//
//  Created by Brian Newton on 21/04/2024.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        }.frame(width: 375, height: 150)
    }
}

#Preview {
    SettingsView()
}
