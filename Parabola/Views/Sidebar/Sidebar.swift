//
//  Sidebar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct Sidebar: View {
    @Binding var sidebarWidth: CGFloat
    @State var urlBar: String = ""
    
    var body: some View {
        GeometryReader { value in
            let size = value.size
            VStack(alignment: .center, spacing: 0, content: {
                TitleBar()
                ZStack {
                    VStack {
                        HStack {
                            Text("youtube.com").font(.caption).foregroundStyle(.gray)
                            Spacer()
                        }
                        .frame(height: 18)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.3))
                        }
                        Spacer()
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, world!")
                        Text("width: \(sidebarWidth)")
                        Text("Geo Width: \(size.width)")
                        Text("Geo height: \(size.height)")
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                
            })
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(maxWidth: sidebarWidth, maxHeight: .infinity)
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).frame(width: 800, height: 528)
}
