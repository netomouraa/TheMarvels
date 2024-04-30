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
    @State private var didAppear = false

    var body: some View {
        VStack {
            Picker(selection: $showFavorites, label: Text("Favorites")) {
                Text("All").tag(false)
                Text("Favorites").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            SearchBar(text: $searchText, onSearch: {
                _ = CharactersListView(viewModel: viewModel.filtered(by: searchText))
            })
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
                ErrorView(errorMessage: "No characters found.") {
                    viewModel.fetchCharacters()
                    searchText = ""
                }
            case .error(let error):
                ErrorView(errorMessage: "Error: \(error.localizedDescription)") {
                    viewModel.fetchCharacters()
                    searchText = ""
                }
            }
            
        }
        .refreshable {
            viewModel.fetchCharacters()
            searchText = ""
        }
        .onAppear {
            if !didAppear {
                viewModel.fetchCharacters()
                didAppear = true
            }
        }
        .environmentObject(viewModel)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

