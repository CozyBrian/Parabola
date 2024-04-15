//
//  LoadingBar.swift
//  Parabola
//
//  Created by Brian Newton on 15/04/2024.
//

import SwiftUI

struct LoadingBar: View {
    @EnvironmentObject var webManager: WebManager
    @State var width: CGFloat = 50
    @State var opacity: CGFloat = 0
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: width, height: 4)
                .opacity(opacity)
                .onChange(of: webManager.isLoading, { _, newValue in
                    if newValue {
                        withAnimation(.easeIn(duration: 0.2), {
                            opacity = 0.3
                        })
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                            withAnimation(.easeIn(duration: 0.2), {
                                width = 120
                            })
                        })
                        withAnimation(.easeIn(duration: 0.6).repeatForever(autoreverses: true), {
                            opacity = 1
                        })
                    } else {
                        withAnimation(.easeIn(duration: 0.2), {
                            width = 50
                        })
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                            withAnimation(.easeIn(duration: 0.3), {
                                opacity = 0
                            })
                        })
                    }
                })
        }
        .padding(.horizontal, 3)
        .frame(maxWidth: .infinity)
        .frame(height: 10)
    }
}
