//
//  View.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI
import AppKit

enum FrostStyle {
    case mute
    case active
}

struct Frost: ViewModifier {
    @State var isHover: Bool = false
    var cornerRadius: CGFloat = 10
    var style: FrostStyle = .active
    
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background {
                switch style {
                case .mute:
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Color(hex: "#EBF2F9").opacity(isHover ? 0.15 : 0))
                case .active:
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Color(hex: "#EBF2F9").opacity(isHover ? 0.25 : 0.15))
                }
            }
            .onHover(perform: { hovering in
                withAnimation(.linear(duration: 0.05), {
                    self.isHover = hovering
                })
            })
    }
}


extension View {
    func frostStyle(cornerRadius: CGFloat = 10, style: FrostStyle = .active) -> some View {
        modifier(Frost(cornerRadius: cornerRadius, style: style))
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
