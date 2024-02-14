//
//  LibraryToggleView.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 14.02.2024.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
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
    
    private let indicatorView: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = .systemGreen
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = 4
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(playlistButton, albumsButton, indicatorView)
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
            height: 40
        )
        albumsButton.frame = CGRect(
            x: playlistButton.right,
            y: 0,
            width: 100,
            height: 40
        )
        layoutIndicatorView()
    }
    
    private func layoutIndicatorView() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(
                x: 0,
                y: playlistButton.bottom,
                width: 100,
                height: 3
            )
        case .album:
            indicatorView.frame = CGRect(
                x: playlistButton.right,
                y: albumsButton.bottom,
                width: 100,
                height: 3
            )
        }
    }
    
    @objc private func didTapPlaylistButton() {
        state = .playlist
        delegate?.libraryToggleViewDidTapPlaylists(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicatorView()
        }
    }
    
    @objc private func didTapAlbumsButton() {
        state = .album
        delegate?.libraryToggleViewDidTapAlbums(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicatorView()
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicatorView()
        }
    }
}
