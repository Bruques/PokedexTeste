//
//  PokemonListCellViewModel.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 07/06/24.
//

import Foundation
import Alamofire
import Combine

class PokemonListCellViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    var pokemon: Result
    var pokemonTypes: [Types] = []
    
    var id = UUID()
    
    init(pokemon: Result) {
        self.pokemon = pokemon
    }
    
    public func fetchPokemonDetail() {
        AF
            .request(pokemon.url)
            .responseDecodable(of: PokemonDetail.self) { result in
                switch result.result {
                case .success(let detail):
                    self.didFetchPokemonDetail(detail)
                case .failure(let error):
                    print("DEU RUIM: \(error)")
                }
            }
    }
    
    private func didFetchPokemonDetail(_ pokemon: PokemonDetail) {
        self.pokemonDetail = pokemon
        self.pokemonTypes = pokemon.types
    }
    
    public func getMainType() -> String {
        return self.pokemonDetail?.types.first?.type.name ?? "normal"
    }
    
    public func getIdNumber() -> String {
        let id = pokemonDetail?.id ?? 0
        let formatedNumber = String(format: "%03d", id)
        return "N°\(formatedNumber)"
    }
}
