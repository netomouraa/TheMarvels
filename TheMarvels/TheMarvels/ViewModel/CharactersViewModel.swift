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
    @Published var favoriteCharacters: [Character] = [] 

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
    
    func toggleFavorite(character: Character) {
         if let index = characters.firstIndex(where: { $0.id == character.id }) {
             characters[index].isFavorite?.toggle()
             UserDefaults.standard.set(characters[index].isFavorite, forKey: "favorite_\(character.id)")
         }
     }
}
