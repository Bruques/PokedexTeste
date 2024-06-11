//
//  PokemonListView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 05/06/24.
//

import SwiftUI
import Alamofire

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    @State private var isLoadingAnimating = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                searchView
                Divider()
                filterButtons
                List {
                    ForEach(viewModel.pokemons, id: \.id) { pokemon in
                        
                        ZStack {
                            PokemonListCellView(viewModel: pokemon)
                                .listRowSeparator(.hidden)
                            NavigationLink(destination: PokemonDetailView(viewModel: viewModel.makePokemonDetailViewModel(detailUrl: pokemon.pokemon.url))) {
                            }.opacity(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                    if viewModel.offSet < 145 {
                        loadingImage
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var searchView: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray700)
                    .frame(width: 20, height: 20)
                TextField("Pesquisar", text: $viewModel.search)
                    .padding(.leading, 8) // Adiciona espaçamento entre o ícone e o texto
            }
            .padding(14)
            .overlay(
                Capsule()
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            .cornerRadius(10)
    }
    
    var filterButtons: some View {
        HStack(spacing: 16) {
            HStack {
                Text("Todos os tipos")
                    .font(FontMaker.makeFont(.poppinsSemiBold, 14))
                    .foregroundStyle(.white)
                Image(systemName: "chevron.down")
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background {
                Capsule()
                    .foregroundStyle(.gray800)
            }
            HStack {
                Text("Menor número")
                    .font(FontMaker.makeFont(.poppinsSemiBold, 14))
                    .foregroundStyle(.white)
                Image(systemName: "chevron.down")
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background {
                Capsule()
                    .foregroundStyle(.gray800)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    var loadingImage: some View {
        Image("ellipse-loading")
            .resizable()
            .frame(width: 60, height: 60)
            .rotationEffect(.degrees(isLoadingAnimating ? 360 : 0))
            .animation(Animation.linear(duration:1).repeatForever(autoreverses: false), value: isLoadingAnimating)
            .onAppear {
                isLoadingAnimating = true
                viewModel.fetchPokemons()
                print("offset: \(viewModel.listUrl)")
            }
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
    }
}

#Preview {
    PokemonListView()
}


