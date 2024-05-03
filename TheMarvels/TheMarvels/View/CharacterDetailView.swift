//
//  CharacterDetailView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI
import MarvelService

struct CharacterDetailView: View {
    @EnvironmentObject var charactersViewModel: CharactersViewModel
    @ObservedObject var characterDetailViewModel: CharacterDetailViewModel
    @State private var sharedImage: Image?
    
    init(character: MarvelCharacter) {
        let characterDetailViewModel = CharacterDetailViewModel(character: character)
        _characterDetailViewModel = ObservedObject(initialValue: characterDetailViewModel)
    }
    
    var body: some View {
        VStack {
            if let thumbnailURL = URL(string: "\(characterDetailViewModel.character.thumbnail.path).\(characterDetailViewModel.character.thumbnail.extension)") {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .onAppear {
                                sharedImage = image
                            }
                            .padding()
                        
                    default:
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
            
            Text(characterDetailViewModel.character.name)
                .font(.title)
                .padding()
            
            Text(characterDetailViewModel.character.description)
                .padding()
            
            Spacer()
        }
        
        .navigationBarItems(trailing:
                                HStack {
            Button(action: {
                charactersViewModel.toggleFavoriteStatus(for: characterDetailViewModel.character)
            }) {
                Image(systemName: characterDetailViewModel.character.isFavorite ?? false ? "star.fill" : "star")
                    .foregroundColor(characterDetailViewModel.character.isFavorite ?? false ? .yellow : .gray)
            }
            if let sharedImage {
                ShareLink(
                    item: sharedImage,
                    preview: SharePreview(
                        "\(characterDetailViewModel.character.name)",
                        image: sharedImage
                    )
                )
            }
            
        }
        )
    }
}
