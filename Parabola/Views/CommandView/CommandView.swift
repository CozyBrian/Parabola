//
//  CommandView.swift
//  Parabola
//
//  Created by Brian Newton on 16/04/2024.
//

import SwiftUI

struct CommandView: View {
    @Binding var showCommand: Bool
    @Binding var view: CGSize
    
    var body: some View {
        if showCommand {
            VStack(alignment: .center, content: {
                Text("Command here")
            })
            .frame(maxWidth: 500)
            .frame(height: 299)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.regularMaterial)
                    .environment(\.colorScheme, .dark)
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black.opacity(0.5))
                    .stroke(.gray, lineWidth: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .border(.gray, width: 1)
                    
            }
            .cornerRadius(10)
            .position(x: (view.width / 2), y: (view.height / 2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.5), radius: 16, x: 0, y: 0)
        } else {
            EmptyView()
        }
        Button(action: {
            showCommand.toggle()
        }, label: {
            EmptyView()
        })
        .opacity(0)
        .keyboardShortcut("k", modifiers: .command)
    }
}
