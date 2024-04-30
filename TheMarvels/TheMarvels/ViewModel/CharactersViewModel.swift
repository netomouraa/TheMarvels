//
//  CharactersViewModel.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation

enum CharactersLoadingState {
    case loading
    case loaded
    case empty
    case error(Error)
}

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private let marvelService: MarvelService
    @Published var favoriteCharacters: [Character] = [] 
    @Published var searchText: String = ""
    @Published var loadingState: CharactersLoadingState = .loading

    func filtered(by searchText: String) -> CharactersViewModel {
        let filteredViewModel = CharactersViewModel()
        filteredViewModel.characters = self.characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        filteredViewModel.favoriteCharacters = self.favoriteCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        return filteredViewModel
    }

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
        loadingState = .loading
        MarvelService.shared.fetchCharacters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters = characters
                    self.loadingState = characters.isEmpty ? .empty : .loaded
                case .failure(let error):
                    switch error {
                    case let nsError as NSError where nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet:
                        self.loadingState = .error(NSError(domain: "No Internet Connection", code: 0, userInfo: nil))
                    case let nsError as NSError where nsError.domain == "Empty character list":
                        self.loadingState = .empty
                    default:
                        self.loadingState = .error(error)
                    }
                }
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
