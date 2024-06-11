//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 09/06/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PokemonDetailViewModel
    @State var isLoadingAnimating: Bool = false
    var body: some View {
        switch viewModel.state {
        case .idle(success: true):
            detail
        default:
            loadingImage
        }
    }
    
    var detail: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Image(systemName: "heart")
                    .foregroundStyle(.white)
            }.padding()
            
            AsyncImage(
                url: URL(string: viewModel.detail?.sprites.front_default ?? "")
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
            Circle()
                .fill(Color.blue)
                .frame(width: 500, height: 500)
                .offset(y: -100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    var loadingImage: some View {
        Image("ellipse-loading")
            .resizable()
            .frame(width: 60, height: 60)
            .rotationEffect(.degrees(isLoadingAnimating ? 360 : 0))
            .animation(Animation.linear(duration:1).repeatForever(autoreverses: false), value: isLoadingAnimating)
            .onAppear {
                isLoadingAnimating = true
            }
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(detailUrl: "https://pokeapi.co/api/v2/pokemon/1/"))
}
