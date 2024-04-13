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
            .foregroundStyle(isPressed ? .white.opacity(0.8) : .gray)
            .aspectRatio(contentMode: .fit)
            .onHover(perform: { hovering in
                withAnimation(.linear(duration: 0.05), {
                    self.isHover = hovering
                })
            }).background{
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(isHover ? 0.3 : 0))
            }.onChange(of: configuration.isPressed, {
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
}
