//
//  AllCategoriesResponse.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 12.02.2024.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
