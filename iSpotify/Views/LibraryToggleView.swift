//
//  LibraryToggleView.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 14.02.2024.
//

import UIKit

class LibraryToggleView: UIView {
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(playlistButton, albumsButton)
        playlistButton.addTarget(self, action: #selector(didTapPlaylistButton), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbumsButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 50
        )
        albumsButton.frame = CGRect(
            x: playlistButton.right,
            y: 0,
            width: 100,
            height: 50
        )
    }
    
    @objc private func didTapPlaylistButton() {
        
    }
    
    @objc private func didTapAlbumsButton() {
        
    }
}
