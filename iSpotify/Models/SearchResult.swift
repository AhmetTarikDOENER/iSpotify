//
//  SearchResult.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 12.02.2024.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
