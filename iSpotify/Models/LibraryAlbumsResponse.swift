//
//  LibraryAlbumsResponse.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 15.02.2024.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let album: Album
    let added_at: String
}
