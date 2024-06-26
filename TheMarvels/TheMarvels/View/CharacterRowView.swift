//
//  CharacterRowView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI
import MarvelService

struct CharacterRowView: View {
    @EnvironmentObject var viewModel: CharactersViewModel
//    @EnvironmentObject var characterDetailViewModel: CharacterDetailViewModel
    let character: MarvelCharacter
    
    var body: some View {
        HStack {
            if let thumbnailURL = URL(string: "\(character.thumbnail.path).\(character.thumbnail.extension)") {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 50, height: 50)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text(character.description.isEmpty ? "Description not available" : character.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleFavoriteStatus(for: character)
            }) {
                Image(systemName: character.isFavorite ?? false ? "star.fill" : "star")
                    .foregroundColor(character.isFavorite ?? false ? .yellow : .gray)
            }
            .padding(.trailing)
        }
    }
}
