//
//  FavoritesListView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import SwiftUI
import MarvelService

struct FavoritesListView: View {
    @ObservedObject var viewModel: CharactersViewModel

    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)
                    .environmentObject(viewModel)) {
                        CharacterRowView(character: character)                    }
            }
            .navigationBarTitle("The Marvels")
            .environmentObject(viewModel)
        }
    }
}
