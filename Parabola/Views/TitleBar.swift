//
//  TitleBar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct TitleBar: View {
//    @Binding var parentWindow: MainWindow
    
    var body: some View {
        HStack {
            Rectangle().fill(.clear).frame(width: 92 - 20, height: 48)
            Button(action: {
                
            }, label: {
                Image(systemName: "sidebar.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 16)
            }).titleButtonStyle()
            Spacer()
            HStack ( spacing: 4, content: {
                Button(action: {
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 14)
                }).titleButtonStyle()
                
                Button(action: {
                }, label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 14)
                }).titleButtonStyle()
                
                Button(action: {
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(7)
                }).titleButtonStyle()
            })
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
//        .background{
//            RoundedRectangle(cornerRadius: 0)
//                .fill(.thickMaterial)
//        }
        .gesture(
            DragGesture()
            .onChanged { value in
//                    let offsetX = value.location.x - value.startLocation.x
//                    let offsetY = value.location.y - value.startLocation.y
//
//                    let coords = parentWindow.frame.origin
//                    let size = parentWindow.frame.size
//
//                    let offCoords = CGPoint(x: coords.x + offsetX, y: coords.y - offsetY)
//
//                    parentWindow.setFrame(NSRect(origin: offCoords, size: size), display: true, animate: false)
            }
        )
    }
}

#Preview {
    TitleBar()
}
