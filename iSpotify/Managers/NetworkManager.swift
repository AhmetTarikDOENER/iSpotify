//
//  NetworkManager.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    //MARK: - Get Albums
    public func getAlbumDetails(
        for album: Album,
        completion: @escaping (Result<AlbumDetailsResponse, APIError>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
            type: .GET
        ) {
            request in
            let task = URLSession.shared.dataTask(with: request) {
                data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get Profile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) {
                data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get Browse
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, APIError>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"),
            type: .GET) {
                request in
                let task = URLSession.shared.dataTask(with: request) {
                    data, _, error in
                    guard let data, error == nil else {
                        completion(.failure(.failedToGetData))
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.failedToGetData))
                    }
                }
                task.resume()
            }
    }
    
    public func getFeaturedPlaylist(completion: @escaping (Result<FeaturedPlaylistResponse, APIError>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=30"), type: .GET) {
            request in
            let task = URLSession.shared.dataTask(with: request) {
                data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, APIError>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) {
            request in
            let task = URLSession.shared.dataTask(with: request) {
                data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(
        genres: Set<String>,
        completion: @escaping (Result<RecommendationsResponse, APIError>) -> Void
    ) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) {
            request in
            let task = URLSession.shared.dataTask(with: request) {
                data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
                    print(error)
                }
            }
            task.resume()
        }
    }
    //MARK: - Request
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken {
            token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
