//
//  MarvelCharacterView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharactersViewModel()
    @State private var showFavorites = false
    @State private var searchText = ""

    var body: some View {
        VStack {
            Picker(selection: $showFavorites, label: Text("Favorites")) {
                Text("All").tag(false)
                Text("Favorites").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Search", text: $searchText)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding(.horizontal)

            if showFavorites {
                FavoritesListView(viewModel: viewModel)
            } else {
                CharactersListView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchCharacters()
            searchText = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

