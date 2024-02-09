//
//  AuthManager.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    struct Constants {
        static let clientID = "72d1408a98a340ac9b693f37fcad13be"
        static let clientSecret = "7bc2dbfcc6374be891b639f0f879ecf8"
    }
    
    public var signInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://iosacademy.io/"
        let string = "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
    
        
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        false
    }
    
    private var accessToken: String? {
        nil
    }
    
    private var refreshToken: String? {
        nil
    }
    
    private var tokenExpirationDate: Date? {
        nil
    }
    
    private var shouldRefreshToken: Bool {
        false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        // Get Token
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
