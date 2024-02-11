//
//  AlbumViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 11.02.2024.
//

import UIKit

class AlbumViewController: UIViewController {

    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        NetworkManager.shared.getAlbumDetails(for: album) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
