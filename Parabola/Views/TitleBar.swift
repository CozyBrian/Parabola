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
            Rectangle().fill(.clear).frame(width: 92 - 24, height: 48)
            Button(action: {
                
            }, label: {
                Image(systemName: "sidebar.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }).titleButtonStyle(padding: 7)
            Spacer()
            HStack ( spacing: 4, content: {
                Button(action: {
                    webManager.webView?.goBack()
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .titleButtonStyle(disabled: !(webManager.webView?.canGoBack ?? false))
                .disabled(!(webManager.webView?.canGoBack ?? false))
                
                Button(action: {
                    webManager.webView?.goForward()
                }, label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .titleButtonStyle(disabled: !(webManager.webView?.canGoForward ?? false))
                .disabled(!(webManager.webView?.canGoForward ?? false))
                
                Button(action: {
                    webManager.webView?.reload()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }).titleButtonStyle(padding: 7.5)
            })
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
    }
}

#Preview {
    TitleBar().environmentObject(WebManager()).frame(width: 270)
}
