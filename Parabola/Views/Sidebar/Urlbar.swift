//
//  Urlbar.swift
//  Parabola
//
//  Created by Brian Newton on 19/04/2024.
//

import SwiftUI

struct Urlbar: View {
    var currentUrl: String = "about:"
    
    var body: some View {
        HStack {
            Text(currentUrl).font(.system(size: 14)).foregroundStyle(.white.opacity(0.8))
            Spacer()
        }
        .frame(height: 18)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frostStyle(cornerRadius: 10)
    }
}

#Preview {
    Urlbar()
}
