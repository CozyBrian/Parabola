//
//  Sidebar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct SidebarTabItem {
    var id: UUID
    var title: String
    var link: String
}

struct Sidebar: View {
    @EnvironmentObject var webManager: WebManager
    @Binding var sidebarWidth: CGFloat
    @State var selectedID: UUID = UUID()
    
    var items: [SidebarTabItem] = [
     SidebarTabItem(id: UUID(), title: "Google", link: "https://www.google.com"),
     SidebarTabItem(id: UUID(), title: "Portfolio", link: "https://www.briannewton.dev"),
     SidebarTabItem(id: UUID(), title: "Youtube", link: "https://www.youtube.com"),
     SidebarTabItem(id: UUID(), title: "Twitter", link: "https://www.x.com")
    ]
    
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
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frostStyle(cornerRadius: 10)
                    
                    TopPinnedTabs()
                    HStack(spacing: 8, content: {
                        Image(systemName: "bolt.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                        
                        Text("MAIN").fontWeight(.semibold).foregroundStyle(.white.opacity(0.4))
                        Spacer()
                        Image(systemName: "ellipsis")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                    })
                    .padding(.horizontal, 12)
                    .frame(height: 36)
                    .frostStyle(style: .mute)
                    Divider()
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 4, content: {
                        Button(action: {
                            print("new tab")
                        }, label: {
                            HStack(spacing: 8, content: {
                                Image(systemName: "plus")
                                    .imageScale(.medium)
                                    .foregroundStyle(.white.opacity(0.4))
                                    .fontWeight(.semibold)
                                
                                Text("New Tab").foregroundStyle(.white.opacity(0.4))
                                Spacer()
                                
                            })
                            .padding(.horizontal, 12)
                            .frame(height: 36)
                        })
                        .sidebarStyle()
                        
                        ForEach(webManager.webViews, id: \.self) { tab in
                            TabItem(title: tab.title ?? "loading..", isSelected: webManager.webView == tab) {
                                webManager.webView = tab
                            }
                        }
                        
                        
                    })
                    
                    
                    
                    Spacer()
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    Text(webManager.isLoading ? "Loading..." : "Done!")
                    Text(webManager.state.localizedName)
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
            }
            .frame(maxWidth: .infinity)
            
        })
        .padding(.horizontal, 8)
        .frame(maxWidth: sidebarWidth, maxHeight: .infinity)
    }
}

struct TopPinnedTabs: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            .frame(height: 48)
            .frostStyle(cornerRadius: 10)
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            .frame(height: 48)
            .frostStyle(cornerRadius: 10)
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            .frame(height: 48)
            .frostStyle(cornerRadius: 10)
            
        }
    }
}


struct TabItem: View {
    @State private var isHover: Bool = false
    var title: String = "Blank"
    var isSelected: Bool = false
    var action: () -> Void
    
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(spacing: 8, content: {
                Image(systemName: "globe")
                    .imageScale(.medium)
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(title).font(.system(size: 14)).foregroundStyle(.white.opacity(0.8))
                Spacer()
            })
            .padding(.horizontal, 12)
            .frame(height: 36)
        })
        .sidebarStyle()
        .onHover(perform: { hovering in
            withAnimation(.linear(duration: 0.05), {
                self.isHover = hovering
            })
        })
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color(hex: "#EBF2F9").opacity(0.15) : .clear)
        }
        
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).environmentObject(WebManager()).frame(width: 800, height: 528)
}
