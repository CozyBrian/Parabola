//
//  Sidebar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var webManager: WebManager
    @Binding var sidebarWidth: CGFloat
    @State var urlBar: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            TitleBar()
            ZStack {
                VStack {
                    HStack {
                        Text(webManager.webView.url!.absoluteString).font(.system(size: 14)).foregroundStyle(.white.opacity(0.8))
                        Spacer()
                    }
                    .frame(height: 18)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#EBF2F9").opacity(0.15))
                    }
                    Spacer()
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    Text(webManager.isLoading ? "Loading..." : "Done!")
                    Text(webManager.state.localizedName)
                    Button("Go To Google", action: {
                        webManager.loadURL("https://www.google.com")
                    })
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
            }
            .frame(maxWidth: .infinity)
            
        })
        .padding(.horizontal, 8)
        .frame(maxWidth: sidebarWidth, maxHeight: .infinity)
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).frame(width: 800, height: 528)
}
