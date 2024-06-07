//
//  Animation+Modifier.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import Foundation
import SwiftUI

public struct AnimatedTapModifier: ViewModifier {
    @State private var isTapped = false
    @State private var condition: Bool = true
    
    public init(condition: Bool = true) {
        self.condition = condition
    }
    
    public func body(content: Content) -> some View {
        if condition {
            content
                .scaleEffect(isTapped ? 0.9 : 1.0)
                .animation(Animation.easeOut(duration: 0.2))
                .onTapGesture {
                    self.isTapped.toggle()
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                        withAnimation {
                            self.isTapped.toggle()
                        }
                    }
                }
        } else {
            content
        }
    }
}
