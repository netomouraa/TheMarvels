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

            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .loaded:
                if showFavorites {
                    if searchText.isEmpty {
                        FavoritesListView(viewModel: viewModel)
                    } else {
                        FavoritesListView(viewModel: viewModel.filtered(by: searchText))
                    }
                } else {
                    if searchText.isEmpty {
                        CharactersListView(viewModel: viewModel)
                    } else {
                        CharactersListView(viewModel: viewModel.filtered(by: searchText))
                    }
                }
            case .empty:
                Text("No characters found.")
            case .error(let error):
                Text("Error: \(error.localizedDescription)")
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

