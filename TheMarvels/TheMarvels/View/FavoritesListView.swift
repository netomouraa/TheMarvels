//
//  FavoritesListView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: CharactersViewModel

    var body: some View {
        NavigationView {
            List(viewModel.filteredFavoriteCharacters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)
                    .environmentObject(viewModel)) {
                        CharacterRowView(character: character)                    }
            }
            .navigationBarTitle("The Marvels")
            .environmentObject(viewModel)
        }
    }
}
