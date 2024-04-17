//
//  TitleBar.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct TitleBar: View {
    @EnvironmentObject var webManager: WebManager
    
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
                    webManager.webView.goBack()
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 14)
                })
                .titleButtonStyle()
                .disabled(!webManager.webView.canGoBack)
                
                Button(action: {
                    webManager.webView.goForward()
                }, label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 14)
                })
                .titleButtonStyle()
                .disabled(!webManager.webView.canGoForward)
                
                Button(action: {
                    webManager.webView.reload()
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
    }
}
