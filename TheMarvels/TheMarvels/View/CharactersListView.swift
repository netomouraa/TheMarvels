//
//  MarvelCharacterView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel = CharactersViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)
                    .environmentObject(viewModel)) {
                        CharacterRowView(character: character)
                    }
            }
            .navigationBarTitle("The Marvels")
            .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}

