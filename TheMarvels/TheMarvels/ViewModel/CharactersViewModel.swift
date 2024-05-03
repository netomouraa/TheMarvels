//
//  CharactersViewModel.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import MarvelService
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters: [MarvelCharacter] = []
    @Published var identifiableError: IdentifiableError?

    private let marvelService = MarvelService.shared
    private var cancellables: Set<AnyCancellable> = []

//    func filtered(by searchText: String) -> CharactersViewModel {
//        let filteredViewModel = CharactersViewModel()
//        filteredViewModel.characters = self.characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        filteredViewModel.favoriteCharacters = self.favoriteCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        return filteredViewModel
//    }
//
//    var filteredCharacters: [MarvelCharacter] {
//        if searchText.isEmpty {
//            return characters
//        } else {
//            return characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        }
//    }
//
//    var filteredFavoriteCharacters: [MarvelCharacter] {
//        if searchText.isEmpty {
//            return favoriteCharacters
//        } else {
//            return favoriteCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        }
//    }
    
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
   
    func toggleFavorite(character: MarvelCharacter) {
         if let index = characters.firstIndex(where: { $0.id == character.id }) {
             characters[index].isFavorite?.toggle()
             UserDefaults.standard.set(characters[index].isFavorite, forKey: "favorite_\(character.id)")
         }
     }
}

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: Error
}
