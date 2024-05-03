//
//  MarvelCharacterView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharactersViewModel()
    @State var showFavorites = false
    @State var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, onSearch: {
                viewModel.fetchCharacters(name: searchText)
            })
            .padding()
            
            Picker(selection: $showFavorites, label: Text("Favorites")) {
                Text("All").tag(false)
                Text("Favorites").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
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
        .alert(item: $viewModel.identifiableError) { identifiableError in
            Alert(title: Text("Error"), message: Text(identifiableError.error.localizedDescription), dismissButton: .default(Text("OK")))
        }
        
        .environmentObject(viewModel)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

