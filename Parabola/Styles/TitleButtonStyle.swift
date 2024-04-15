//
//  File.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct TitleButtonStyle: ButtonStyle {
    @State private var isHover: Bool = false
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .frame(width: 32, height: 32)
            .foregroundStyle(isPressed ? Color(hex: "#EBF2F9").opacity(0.8) : Color(hex: "#EBF2F9").opacity(0.6))
            .aspectRatio(contentMode: .fit)
            .onHover(perform: { hovering in
                withAnimation(.linear(duration: 0.05), {
                    self.isHover = hovering
                })
            }).background{
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "#EBF2F9").opacity(isHover ? 0.1 : 0))
            }.onChange(of: configuration.isPressed, {
                withAnimation(.linear(duration: 0.05), {
                    self.isPressed = configuration.isPressed
                })
            })
    }
}

struct SidebarButtonStyle: ButtonStyle {
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
//            .foregroundStyle(isPressed ? Color(hex: "#EBF2F9").opacity(0.8) : Color(hex: "#EBF2F9").opacity(0.6))
            .frostStyle(style: isPressed ? .active : .mute)
            .scaleEffect(isPressed ? 0.99 : 1)
            .onChange(of: configuration.isPressed, {
                withAnimation(.linear(duration: 0.05), {
                    self.isPressed = configuration.isPressed
                })
            })
    }
}

extension Button {
    func titleButtonStyle() -> some View {
        self.buttonStyle(TitleButtonStyle())
    }
    
    func sidebarStyle() -> some View {
        self.buttonStyle(SidebarButtonStyle())
    }
}
