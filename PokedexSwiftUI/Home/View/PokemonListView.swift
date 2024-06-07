//
//  PokemonListView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import SwiftUI
import Alamofire

struct PokemonListView: View {
    @State private var pokemons: [Result] = []
    
    @State private var pokemonDetail = PokemonDetail(sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
    
    var body: some View {
        VStack {
            List(pokemons, id: \.self) { pokemon in
//                pokemonCell(pokemon: pokemon)
                PokemonListCell(pokemon: pokemon)
            }
            .onAppear {
                AF
                    .request("https://pokeapi.co/api/v2/pokemon")
                    .responseDecodable(of: PokemonListResponse.self) { response in
                        switch response.result {
                        case .success(let results):
                            self.pokemons = results.results
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
            }
        }
    }
    
    func pokemonCell(pokemon: Result) -> some View {
        HStack {
            Text(pokemon.name)
            AsyncImage(
                url: getImages(urlDetail: pokemon.url)
            ) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
        }
    }
    
    private func getImages(urlDetail: String) -> URL? {
        var pokemon: PokemonDetail?
        AF
            .request(urlDetail)
            .responseDecodable(of: PokemonDetail.self) { result in
                switch result.result {
                case .success(let result):
                    pokemon = result
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        guard let url = pokemon?.sprites.front_default else {
            return nil
        }
        return URL(string: url)
    }
}

#Preview {
    PokemonListView()
}

struct PokemonListCell: View {
    var pokemon: Result
    @State var imageString: String = ""
    var body: some View {
        HStack {
            Text(pokemon.name)
            AsyncImage(
                url: URL(string: imageString)
            ) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
        }
        .onAppear {
            AF
                .request(pokemon.url)
                .responseDecodable(of: PokemonDetail.self) { result in
                    switch result.result {
                    case .success(let detail):
                        self.imageString = detail.sprites.front_default
                    case .failure(let error):
                        print("DEU RUIM: \(error)")
                    }
                }
        }
    }
}
