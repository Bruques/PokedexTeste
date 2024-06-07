//
//  UserSession.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 19/02/24.
//

import Foundation

final class UserSession: ObservableObject {
    @Published private (set) var user: User?
    
    func setUser(_ user: User) {
        self.user = user
    }
}
