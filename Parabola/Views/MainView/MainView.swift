//
//  MainView.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI

struct MainView: View {
    @State var opacity: CGFloat = 0.18
    @State var opacity2: CGFloat = 0.7
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to Parabola!")
                    .font(.title)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.18))
                    .shadow(color: Color.black.opacity(0.7), radius: 2.5, x: 0, y: 0)
                    .opacity(1)
            }
        }.padding([.vertical,.trailing], 10)
    }
}

#Preview {
    MainView()
}

// 20.5 12 8 12 8 12 20.5
