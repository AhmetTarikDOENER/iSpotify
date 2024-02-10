//
//  RecommendationsResponse.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 10.02.2024.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
