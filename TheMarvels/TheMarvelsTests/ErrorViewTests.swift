//
//  ErrorViewTests.swift
//  TheMarvelsTests
//
//  Created by Neto Moura on 30/04/24.
//

import XCTest
@testable import TheMarvels

class ErrorViewTests: XCTestCase {
    
    func testErrorView() {
        let view = ErrorView(errorMessage: "Error Message", onRetry: {})
        
        XCTAssertNotNil(view)
    }

}
