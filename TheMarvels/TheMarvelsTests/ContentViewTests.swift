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
        
        XCTAssertTrue(contentView.showFavorites == false)
        XCTAssertTrue(contentView.searchText.isEmpty)
    }
    
    func test_ContentView_SearchBar() {
        let contentView = ContentView()
        
        contentView.searchText = "Test"
        
//        XCTAssertEqual(contentView.searchText, "Test")
    }
    
    func test_ContentView_PickerSelection() {
        let contentView = ContentView()

        XCTAssertTrue(contentView.$showFavorites.wrappedValue == false)

        contentView.$showFavorites.wrappedValue = true

//        XCTAssertTrue(contentView.$showFavorites.wrappedValue == true)
    }
    
    func test_ContentView_ListViews() {
        let contentView = ContentView()

//        XCTAssertTrue(contentView.body is CharactersListView)
//
//        contentView.$showFavorites.wrappedValue = true
//
//        XCTAssertTrue(contentView.body is FavoritesListView)
    }

}
