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
    @Published var searchText: String = ""

    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var filteredFavoriteCharacters: [Character] {
        if searchText.isEmpty {
            return favoriteCharacters
        } else {
            return favoriteCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
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
