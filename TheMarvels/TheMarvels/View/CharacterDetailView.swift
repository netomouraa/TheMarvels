//
//  CharacterDetailView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            if let thumbnailURL = URL(string: "\(character.thumbnail.path).\(character.thumbnail.extension)") {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
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
            
            Text(character.name)
                .font(.title)
                .padding()
            
            Text(character.description)
                .padding()
            
            Spacer()
        }
//        .navigationBarTitle("Character Detail")
    }
}
