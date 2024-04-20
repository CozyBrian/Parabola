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
    var size: CGFloat = 32
    var padding: CGFloat = 8.0
    var disabled: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .padding(.all, padding)
            .frame(width: size, height: size)
            .foregroundStyle(
                isPressed ?
                Color(hex: "#EBF2F9").opacity(0.8) :
                    disabled ?
                Color(hex: "#EBF2F9").opacity(0.3) :
                Color(hex: "#EBF2F9").opacity(0.6)
            )
            .aspectRatio(contentMode: .fit)
            .onHover(perform: { hovering in
                if !disabled {
                    withAnimation(.linear(duration: 0.05), {
                        self.isHover = hovering
                    })
                }
            }).background{
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "#EBF2F9").opacity(isHover ? 0.1 : 0))
            }.onChange(of: configuration.isPressed, {
                if !disabled {
                    withAnimation(.linear(duration: 0.05), {
                        self.isPressed = configuration.isPressed
                    })
                }
            })
    }
}

struct SidebarButtonStyle: ButtonStyle {
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
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
    func titleButtonStyle(
        size: CGFloat = 32,
        padding: CGFloat = 8,
        disabled: Bool = false
    ) -> some View {
        self.buttonStyle(TitleButtonStyle(
            size: size,
            padding: padding,
            disabled: disabled
        ))
    }
    
    func sidebarStyle() -> some View {
        self.buttonStyle(SidebarButtonStyle())
    }
}
