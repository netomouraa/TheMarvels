//
//  CharacterDetailView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct CharacterDetailView: View {
    @EnvironmentObject var charactersViewModel: CharactersViewModel
    @ObservedObject var characterDetailViewModel: CharacterDetailViewModel
    
    init(character: Character) {
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
                        Button("Share Image") {
//                            guard let image = UIImage(data: characterDetailViewModel.character.imageData) else { return }
                            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                        
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                if let window = windowScene.windows.first {
                                    window.rootViewController?.present(activityViewController, animated: true, completion: nil)
                                }
                            }
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
        .navigationBarTitle("Character Detail")
        .navigationBarItems(trailing:
                                Button(action: {
            characterDetailViewModel.toggleFavorite()
        }) {
            if let isFavorite = characterDetailViewModel.character.isFavorite {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            } else {
                Image(systemName: "star")
                    .foregroundColor(.gray)
            }
        }
        )
    }
}
