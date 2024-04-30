//
//  CharactersViewModel.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation

import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private let marvelService: MarvelService
    
    init(marvelService: MarvelService = MarvelService()) {
        self.marvelService = marvelService
    }
    
    func fetchCharacters() {
        MarvelService.shared.fetchCharacters { characters in
            DispatchQueue.main.async {
                self.characters = characters
            }
        }
    }
    

    //    func fetchCharacters() {
    //        marvelService.fetchCharacters { [weak self] result in
    //            switch result {
    //            case .success(let characters):
    //                DispatchQueue.main.async {
    //                    self?.characters = characters
    //                }
    //            case .failure(let error):
    //                print("Erro ao buscar personagens: \(error)")
    //            }
    //        }
    //    }
}
