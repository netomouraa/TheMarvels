//
//  CharacterDetailViewModel.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import SwiftUI
import MarvelService

class CharacterDetailViewModel: ObservableObject {
    @Published var character: MarvelCharacter
    
    init(character: MarvelCharacter) {
        self.character = character
//        if let isFavorite = UserDefaults.standard.value(forKey: "favorite_\(character.id)") as? Bool {
//            self.character.isFavorite = isFavorite
//        }
    }
    
//    func toggleFavorite() {
//        if let currentIsFavorite = character.isFavorite {
//            character.isFavorite = !currentIsFavorite
//            UserDefaults.standard.set(!currentIsFavorite, forKey: "favorite_\(character.id)")
//        } else {
//            character.isFavorite = true
//            UserDefaults.standard.set(true, forKey: "favorite_\(character.id)")
//        }
//    }
}

