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

struct FloatingView: ViewModifier {
    var cornerRadius: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.regularMaterial)
                    .environment(\.colorScheme, .dark)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.black.opacity(0.5))
                    .stroke(.gray.opacity(0.4), lineWidth: 1.5)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
            .cornerRadius(cornerRadius)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.5), radius: 16, x: 0, y: 0)
    }
}

struct CommandBarItemView: ViewModifier {
    var isSelected: Bool = false
    @State var isHover: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onHover(perform: { hovering in
                withAnimation(.linear(duration: 0.025), {
                    self.isHover = hovering
                })
            })
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        isHover ?
                        isSelected ? .clear  :
                        Color(hex: "#3A3A3A").opacity(0.4) :
                                .clear)
                    .if(isSelected, transform: { content in
                        content.fill(Color(hex: "#39414A").opacity(0.4))
                    })
                    .environment(\.colorScheme, .dark)
            }
    }
}


extension View {
    func frostStyle(cornerRadius: CGFloat = 10, style: FrostStyle = .active) -> some View {
        modifier(Frost(cornerRadius: cornerRadius, style: style))
    }
    
    func floatingStyle(cornerRadius: CGFloat = 10) -> some View {
        modifier(FloatingView(cornerRadius: cornerRadius))
    }
    
    func commandBarItemStyle(_ isSelected: Bool = false) -> some View {
        modifier(CommandBarItemView(isSelected: isSelected))
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
