//
//  ContentViewTests.swift
//  TheMarvelsTests
//
//  Created by Neto Moura on 03/05/24.
//

import XCTest
import SwiftUI
@testable import TheMarvels

class ContentViewTests: XCTestCase {
    
    func test_ContentView_InitialState() {
        let contentView = ContentView()
        
        // Verifique se os estados são inicializados corretamente
        XCTAssertTrue(contentView.showFavorites == false)
        XCTAssertTrue(contentView.searchText.isEmpty)
    }
    
    func test_ContentView_SearchBar() {
        let contentView = ContentView()
        
        // Simule uma pesquisa
        contentView.searchText = "Test"
        
        // Verifique se o texto de pesquisa foi atualizado corretamente
        XCTAssertEqual(contentView.searchText, "Test")
    }
    
    // Adicione mais testes conforme necessário para verificar a interação com outros elementos da interface do usuário
    
    // Teste para verificar se a ação de busca executa corretamente
//    func test_ContentView_SearchAction() {
//        let contentView = ContentView()
//        let viewModel = CharactersViewModel()
//        contentView.viewModel = viewModel
//        
//        // Simule a ação de busca
//        contentView.searchText = "Character Name"
//        contentView.viewModel.fetchCharacters(name: contentView.searchText)
//        
//        // Verifique se o método fetchCharacters() do viewModel foi chamado corretamente
//        XCTAssertEqual(viewModel.lastFetchedName, contentView.searchText)
//    }
    
    func test_ContentView_PickerSelection() {
        let contentView = ContentView()

        // Verifique o estado inicial
        XCTAssertTrue(contentView.$showFavorites.wrappedValue == false)

        // Simule a seleção do Picker
        contentView.$showFavorites.wrappedValue = true

        // Verifique se a seleção foi alterada corretamente
        XCTAssertTrue(contentView.$showFavorites.wrappedValue == true)
    }
    
    func test_ContentView_ListViews() {
        let contentView = ContentView()

        // Verifique se a exibição inicial é CharactersListView
        XCTAssertTrue(contentView.body is CharactersListView)

        // Simule a alteração do Picker para exibir os favoritos
        contentView.$showFavorites.wrappedValue = true

        // Verifique se a exibição agora é FavoritesListView
        XCTAssertTrue(contentView.body is FavoritesListView)
    }

}
