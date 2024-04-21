//
//  Sidebar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var webManager: WebManager
    @EnvironmentObject var globalSettings: GlobalSettings
    @Binding var sidebarWidth: CGFloat
    @State var selectedID: UUID = UUID()
    @State var toggleDebug: Bool = false
    @State var showUrlBarOverlay: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            TitleBar()
            ZStack {
                VStack {
                    Urlbar(
                        currentUrl: webManager.webView?.url?.absoluteString ?? "about:parabola"
                    )
                    .onTapGesture {
                        showUrlBarOverlay.toggle()
                    }
                    .overlay(content: {
                        if showUrlBarOverlay {
                            VStack(content: {
                                /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                            })
                            .padding(.horizontal, 8.5)
                            .frame(width: (sidebarWidth - 16).clamped(to: 320...370), height: 100)
                            .floatingStyle()
                            .position(x: (sidebarWidth - 16).clamped(to: 320...370) / 2, y: 90)
                        }
                    })
                    .zIndex(2)
                    
                    TopPinnedTabs()
                    TabSectionHeader()
                    Divider()
                    VStack(spacing: 4, content: {
                        NewTabButton()
                        
                        ForEach(webManager.webViews, id: \.self) { tab in
                            TabItem(
                                title: tab.title ?? "loading",
                                url: tab.url,
                                isSelected: webManager.isActive(tab),
                                onEvent: { event in
                                   switch event {
                                       case .onClicked:
                                           webManager.setMainWebview(tab)
                                       case .onClose:
                                           webManager.removeFromWebviews(tab)
                                   }
                                })
                        }
                    })

                    Spacer()
                    HStack {
                        ScrimLoader()
                        if globalSettings.debugMode {
                            VStack(alignment: .leading, content: {
                                Button(action: {
                                    webManager.removeMainWebview()
                                    print(webManager.webView as Any)
                                }, label: {
                                    HStack {
                                        Text("Clear Main Webview")
                                    }.frame(height: 36)
                                }).sidebarStyle()
                                Button(action: {
                                    print(webManager.webView as Any)
                                }, label: {
                                    HStack {
                                        Text("Print Main WebView")
                                    }.frame(height: 36)
                                }).sidebarStyle()
                                Text("isLoading: \(webManager.isLoading ? "Loading..." : "Done!")")
                                HStack {
                                    Text("state:")
                                    Text(webManager.state.localizedName)
                                }
                            }).padding(.vertical, 8)
                        }
                        Spacer()
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            
        })
        .padding(.horizontal, 8)
        .frame(maxWidth: sidebarWidth, maxHeight: .infinity)
    }
}

struct TabSectionHeader: View {
    var body: some View {
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
    }
}

struct NewTabButton: View {
    var body: some View {
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
    }
}

#Preview {
    Sidebar(sidebarWidth: Binding.constant(270))
        .environmentObject(WebManager())
        .environmentObject(GlobalSettings())
        .frame(height: 528)
}
