//
//  PokemonListViewModel.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 07/06/24.
//

import Foundation
import Alamofire

class PokemonListViewModel: ObservableObject {
    @Published public var pokemons: [PokemonListCellViewModel] = []
    @Published public var search: String = ""
    public var listUrl = "https://pokeapi.co/api/v2/pokemon"
    
    public var offSet = 0
    
    init() {
        
    }
    
    public func fetchPokemons() {
        AF
            .request(listUrl)
            .responseDecodable(of: PokemonListResponse.self) { response in
                switch response.result {
                case .success(let results):
                    self.listUrl = results.next
                    self.makePokemonCellViewModels(results.results)
                    self.offSet += 20
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    
    private func makePokemonCellViewModels(_ pokemons: [Result]) {
        self.pokemons += pokemons.map { pokemon in
            PokemonListCellViewModel(pokemon: pokemon)
        }
    }
}
