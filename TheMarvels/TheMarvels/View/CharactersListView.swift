//
//  CharactersListView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import SwiftUI
import MarvelService

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.characters, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(character: character)
                    .environmentObject(viewModel)) {
                        CharacterRowView(character: character)
                    }
                    .onAppear {
                        if self.viewModel.shouldLoadNextPage(character: character) {
                            self.viewModel.fetchCharacters()
                        }
                    }
            }
            .navigationBarTitle("The Marvels")
            .environmentObject(viewModel)
            .refreshable {
                self.viewModel.fetchCharacters()
            }
        }
    }
}
