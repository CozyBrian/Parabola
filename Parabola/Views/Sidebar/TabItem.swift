//
//  TabItem.swift
//  Parabola
//
//  Created by Brian Newton on 19/04/2024.
//

import SwiftUI
import FaviconFinder


struct TabItem: View {
    enum TabEvents {
        case onClicked
        case onClose
    }
    
    @State private var isHover: Bool = false
    var title: String = "Blank"
    var url: URL?
    var isSelected: Bool = false
    var onEvent: (TabEvents) -> Void
    @State var favicon: NSImage = NSImage(systemSymbolName: "globe", accessibilityDescription: "globe")!
    
    var body: some View {
        Button(action: {
            onEvent(.onClicked)
        }, label: {
            HStack(spacing: 8, content: {
                Image(nsImage: favicon)
                    .resizable()
                    .imageScale(.medium)
                    .foregroundStyle(.white.opacity(0.8))
                    .frame(width: 16, height: 16)
                
                Text(title).font(.system(size: 14)).foregroundStyle(.white.opacity(0.8))
                    .lineLimit(1)
                Spacer()
                
                if isHover {
                    Button(action: {
                        onEvent(.onClose)
                    }, label: {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                            .foregroundStyle(.white.opacity(0.6))
                            .fontWeight(.semibold)
                    }).titleButtonStyle(size: 24, padding: 0)
                }
            })
            .padding(.leading, 12)
            .padding(.trailing, 6)
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
        .task {
            do {
                let favicon = try await FaviconFinder(url: url ?? URL(string: "https://www.briannewton.dev")!)
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
    TabItem(onEvent: { event in
        switch event {
            case .onClicked:
                print("clicked")
            case .onClose:
                print("close")
        }
     }).frame(width: 260).padding()
}
