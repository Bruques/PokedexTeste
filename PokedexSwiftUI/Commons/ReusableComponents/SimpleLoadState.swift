//
//  SimpleLoadState.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import Foundation

public enum SimpleLoadState: Equatable {
    case loading
    case idle(success: Bool)
}
