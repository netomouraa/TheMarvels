//
//  Response.swift
//  TheMarvels
//
//  Created by Neto Moura on 30/04/24.
//

import Foundation
import SwiftUI

struct Response: Decodable {
    let code: Int
    let status: String
    let data: CharacterDataWrapper
}

struct CharacterDataWrapper: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let comics: Collection
    let series: Collection
    let stories: Collection
    let events: Collection
    let urls: [URLInfo]
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
}

struct Collection: Decodable {
    let available: Int
    let collectionURI: String
    let items: [CollectionItem]
    let returned: Int
}

struct CollectionItem: Decodable {
    let resourceURI: String
    let name: String
}

struct URLInfo: Decodable {
    let type: String
    let url: String
}
