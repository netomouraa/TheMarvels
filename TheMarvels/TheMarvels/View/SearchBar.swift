//
//  SearchBar.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search by name", text: $text, onCommit: {
                if !text.isEmpty {
                    onSearch()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .overlay(
                HStack {
                    Spacer()
                    Button(action: {
                        text = ""
                        hideKeyboard()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 20)
                    }
                }
            )

            Button(action: {
                if !text.isEmpty {
                    onSearch()
                    hideKeyboard()
                }
            }) {
                Text("Search")
            }
            .padding(.trailing)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
