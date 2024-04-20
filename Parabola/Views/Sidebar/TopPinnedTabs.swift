//
//  TopPinnedTabs.swift
//  Parabola
//
//  Created by Brian Newton on 19/04/2024.
//

import SwiftUI
import FaviconFinder

struct TopPinnedTabs: View {
    @EnvironmentObject var webManager: WebManager
    
    var body: some View {
        HStack {
            ForEach(webManager.pinnedWebviews, id: \.self) { tab in
                PinnedTab(
                    url: tab.url,
                    isSelected: webManager.isActive(tab),
                    onClick: {
                        webManager.setMainWebview(tab)
                    }
                )
            }
        
        }
    }
}

struct PinnedTab: View {
    var url: URL?
    var isSelected: Bool = false
    var onClick: () -> Void
    @State var favicon: NSImage = NSImage(systemSymbolName: "globe", accessibilityDescription: "globe")!
    
    var body: some View {
        Button(action: {
            onClick()
        }, label: {
            VStack {
                Image(nsImage: favicon)
                    .resizable()
                    .imageScale(.large)
                    .foregroundStyle(.white.opacity(0.8))
                    .frame(width: 18, height: 18)
            }
            .frame(height: 48)
            .frostStyle(cornerRadius: 10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(isSelected ? Color(hex: "#EBF2F9").opacity(0.25) : .clear)
                    .stroke(isSelected ? Color(hex: "#EBF2F9").opacity(0.55) : .clear, style: .init(lineWidth: 2))
            }
        })
        .buttonStyle(.plain)
        .task {
            do {
                let favicon = try await FaviconFinder(url: url!)
                            .fetchFaviconURLs()
                            .download()
                            .largest()
                guard let faviImage = favicon.image else {
                    return
                }
                self.favicon = faviImage.image
            } catch {
                self.favicon = NSImage(systemSymbolName: "globe", accessibilityDescription: "globe")!
            }
        }
    }
}

#Preview {
    TopPinnedTabs()
}
