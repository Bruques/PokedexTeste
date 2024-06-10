//
//  PokemonListCellView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 07/06/24.
//

import Foundation
import SwiftUI

struct PokemonListCellView: View {
    @ObservedObject var viewModel: PokemonListCellViewModel
    var body: some View {
        HStack {
            pokemonDetail
            Spacer()
            pokemonImage
        }
        .background {
            ColorUtils.getColorForPokemonType(
                type: viewModel.pokemonTypes.first?.type.name ?? ""
            )
                .opacity(0.15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear {
            self.viewModel.fetchPokemonDetail()
        }
    }
    
    var pokemonDetail: some View {
        VStack(alignment: .leading) {
            Text(viewModel.getIdNumber())
                .font(FontMaker.makeFont(.poppinsSemiBold, 12))
            Spacer().frame(height: 4)
            Text("\(viewModel.pokemon.name.capitalized)")
                .font(FontMaker.makeFont(.poppinsSemiBold, 21))
            Spacer().frame(height: 16)
            pokemonType
        }
        .padding(.leading)
    }
    
    var pokemonType: some View {
        HStack {
            ForEach(viewModel.pokemonTypes, id: \.type.name) { type in
                HStack(spacing: 6) {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .overlay {
                            Image(type.type.name)
                                .resizable()
                                .frame(width: 12, height: 12)
                        }
                    Text(type.type.name.capitalized)
                        .font(FontMaker.makeFont(.poppinsMedium, 11))
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .background {
                    Capsule()
                        .foregroundStyle(ColorUtils.getColorForPokemonType(type: type.type.name))
                }
            }
        }
    }
    
    var pokemonImage: some View {
        ZStack {
            Image(viewModel.getMainType())
                .renderingMode(.template)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            ColorUtils.getColorForPokemonType(type: viewModel.getMainType()),
                            Color.white
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            
            AsyncImage(
                url: URL(string: viewModel.pokemonDetail?.sprites.front_default ?? "")
            ) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(ColorUtils.getColorForPokemonType(type: viewModel.getMainType()))
        }
    }
}

#Preview {
    let pokemon = Result(name: "bulbassaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
    let viewModel = PokemonListCellViewModel(pokemon: pokemon)
    return PokemonListCellView(viewModel: viewModel)
}
