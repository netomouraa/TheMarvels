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
    private let limit = 20
    private var offset = 0
    private var currentPage = 0

    func fetchCharacters(name: String? = nil) {
        marvelService.fetchCharacters(name: name, limit: limit, offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.identifiableError = IdentifiableError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { characters in
                self.characters.append(contentsOf: characters)
                self.offset += self.limit
                self.identifiableError = nil
            }
            .store(in: &cancellables)
    }
   
    func shouldLoadNextPage(character: MarvelCharacter) -> Bool {
         guard let lastCharacter = characters.last else { return false }
         return character.id == lastCharacter.id
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
