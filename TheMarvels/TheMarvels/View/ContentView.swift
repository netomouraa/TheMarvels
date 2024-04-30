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
    
    var body: some View {
        VStack {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

