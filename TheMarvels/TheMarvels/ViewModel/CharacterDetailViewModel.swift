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
    }
}
