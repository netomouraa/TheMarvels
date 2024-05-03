//
//  CharactersViewModel.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import MarvelService
import Combine

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: Error
}

class CharactersViewModel: ObservableObject {
    @Published var characters: [MarvelCharacter] = []
    private let favoritesKey = "FavoriteCharacters"
    private var favoriteCharacterIDs: Set<Int> = []

    private let marvelService = MarvelService.shared
    private var cancellables: Set<AnyCancellable> = []
    @Published var identifiableError: IdentifiableError?

    func fetchCharacters(name: String? = nil) {
        marvelService.fetchCharacters(name: name)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.identifiableError = IdentifiableError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { characters in
                self.characters = characters
                self.identifiableError = nil
            }
            .store(in: &cancellables)
    }
   
    func toggleFavoriteStatus(for character: MarvelCharacter) {
        guard let index = characters.firstIndex(where: { $0.id == character.id }) else { return }
        characters[index].isFavorite = !(characters[index].isFavorite ?? false)
        saveFavoriteCharacterIDs()
    }
        
    func favoriteCharacters() -> [MarvelCharacter] {
        return characters.filter { $0.isFavorite ?? false }
    }
    
    private func loadFavoriteCharacterIDs() {
        if let savedFavoriteCharacterIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            favoriteCharacterIDs = Set(savedFavoriteCharacterIDs)
        }
    }
    
    private func saveFavoriteCharacterIDs() {
        let characterIDs = characters.filter { $0.isFavorite ?? false }.map { $0.id }
        UserDefaults.standard.set(Array(characterIDs), forKey: favoritesKey)
    }
}
