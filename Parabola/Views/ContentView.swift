//
//  ContentView.swift
//  Parabola
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var sidebarWidth: CGFloat = 273
    @State var showCommand: Bool = false
    private weak var parentWindow: MainWindow!
    
    
    init(parentWindow: MainWindow) {
        self.parentWindow = parentWindow
    }
    
    var body: some View {
        GeometryReader { value in
            let size = value.size
            
            ZStack(alignment: .leading, content: {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                    Sidebar(sidebarWidth: $sidebarWidth)
                        .zIndex(2)
                    MainView()
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                ResizeHandle(sidebarWidth: $sidebarWidth, view: Binding.constant(size))
                CommandView(showCommand: $showCommand, view: Binding.constant(size))
            })
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(hex: "#8EAFD2").opacity(0.3))
            }
            .cornerRadius(14)
        }
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).frame(width: 800, height: 528)
}
