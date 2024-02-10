//
//  FeaturedPlaylistResponse.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 10.02.2024.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
