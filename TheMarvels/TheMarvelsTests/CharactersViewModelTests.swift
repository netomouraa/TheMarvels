//
//  CharactersViewModelTests.swift
//  TheMarvelsTests
//
//  Created by Neto Moura on 30/04/24.
//

import XCTest
@testable import TheMarvels

class CharactersViewModelTests: XCTestCase {
    
    var viewModel: CharactersViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CharactersViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchCharacters() {
        let expectation = XCTestExpectation(description: "Fetch characters")
        
        viewModel.fetchCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.characters)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testToggleFavorite() {
//        let character = MarvelCharacter(id: 123, name: "Test", description: "Test Description", modified: "", thumbnail: MarvelThumbnail(path: "", extension: ""), comics: MarvelCollection(available: 0, collectionURI: "", items: [], returned: 0), series: MarvelCollection(available: 0, collectionURI: "", items: [], returned: 0), stories: MarvelCollection(available: 0, collectionURI: "", items: [], returned: 0), events: MarvelCollection(available: 0, collectionURI: "", items: [], returned: 0), urls: [])
//        viewModel.characters = [character]
//        
//        viewModel.toggleFavorite(character: character)
//        
//        XCTAssertTrue(viewModel.characters.first?.isFavorite == true)
    }
}
