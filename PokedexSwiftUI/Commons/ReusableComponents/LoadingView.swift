//
//  LoadingView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Image("ellipse-loading")
                .resizable()
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration:1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(PokedexColors.darkBlue)
    }
}

#Preview {
    LoadingView()
}
