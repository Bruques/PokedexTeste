//
//  PokemonModels.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import Foundation

struct PokemonListResponse: Codable {
    var next: String
    var results: [Result]
}

struct Result: Codable, Hashable {
    var name: String
    var url: String
}

struct PokemonDetail: Codable {
    var id: Int
    var sprites: Sprites
    var types: [Types]
}

struct CompletePokemonDetail: Codable {
    var id: Int
    var sprites: Sprites
    var types: [Types]
}

struct Sprites: Codable {
    var front_default: String
}

struct Types: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
}
