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
        .refreshable {
            self.resetView()
        }
        .onAppear {
            self.resetView()
        }
        .alert(item: $viewModel.identifiableError) { identifiableError in
            Alert(title: Text("Error"), message: Text(identifiableError.error.localizedDescription), dismissButton: .default(Text("OK")))
        }
        
        .environmentObject(viewModel)
    }
    
    func resetView(){
        viewModel.fetchCharacters()
        searchText = ""
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

