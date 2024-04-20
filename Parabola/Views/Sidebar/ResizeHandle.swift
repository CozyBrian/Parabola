//
//  ResizeHandle.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct ResizeHandle: View {
    @Binding var sidebarWidth: CGFloat
    @Binding var view: CGSize
    
    @State var minWidthValue: CGFloat = 240
    
    var body: some View {
        VStack {}
            .frame(width: 16, height: view.height)
            .background(.blue.opacity(0.005))
            .gesture(DragGesture().onChanged { value in
                let offsetX = value.location.x - value.startLocation.x
                sidebarWidth = (sidebarWidth + offsetX).clamped(to: 240...400)
            })
            .position(x: sidebarWidth, y: view.height / 2)
    }
}
