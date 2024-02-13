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
    
    //MARK: - Search
    public func search(
        with query: String,
        completion: @escaping (Result<[SearchResult], APIError>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/search?limit=12&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET
        ) {
            request in
            print(request.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: request) {
                data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap { .track(model: $0)})
                    searchResults.append(contentsOf: result.albums.items.compactMap { .album(model: $0)})
                    searchResults.append(contentsOf: result.artists.items.compactMap { .artist(model: $0)})
                    searchResults.append(contentsOf: result.playlists.items.compactMap { .playlist(model: $0)})
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get Categories
    public func getCategories(completion: @escaping (Result<[Category], APIError>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
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
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylist(
        category: Category,
        completion: @escaping (Result<[Playlist], APIError>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"),
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
                    let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
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
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get Playlist
    public func getPlaylistDetails(
        for playlist: Playlist,
        completion: @escaping (Result<PlaylistDetailsResponse, APIError>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
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
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToGetData))
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
