//
//  ErrorView.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Button(action: {
                onRetry()
            }) {
                Image(systemName: "arrow.clockwise.circle")
                    .imageScale(.large)
                    .padding()
            }
        }
    }
}
