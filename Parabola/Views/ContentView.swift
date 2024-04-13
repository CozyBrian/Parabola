//
//  ContentView.swift
//  Parabola
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var sidebarWidth: CGFloat = 273
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
                    MainView()
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                ResizeHandle(sidebarWidth: $sidebarWidth, view: Binding.constant(size))
            })
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
            }
            .cornerRadius(14)
        }
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).frame(width: 800, height: 528)
}
