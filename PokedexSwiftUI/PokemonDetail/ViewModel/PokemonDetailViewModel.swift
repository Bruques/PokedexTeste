//
//  PokemonDetailViewModel.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 09/06/24.
//

import SwiftUI
import Alamofire

class PokemonDetailViewModel: ObservableObject {
    @Published var detail: CompletePokemonDetail?
    @Published var state: SimpleLoadState = .idle(success: true)
    @Published var detailUrl: String
    
    init(detailUrl: String) {
        self.detailUrl = detailUrl
        getPokemonDetail()
    }
    
    public func getPokemonDetail() {
        self.state = .loading
        AF
            .request(detailUrl)
            .responseDecodable(of: CompletePokemonDetail.self) { response in
                switch response.result {
                case .success(let response):
                    self.detail = response
                    self.state = .idle(success: true)
                case .failure:
                    print("Deu erro do get dos detalhes")
                }
            }
    }
}
