//
//  PokemonModels.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import Foundation

struct PokemonListResponse: Codable {
    var results: [Result]
}

struct Result: Codable, Hashable {
    var name: String
    var url: String
}

struct PokemonDetail: Codable {
    var sprites: Sprites
}

struct Sprites: Codable {
    var front_default: String
}
