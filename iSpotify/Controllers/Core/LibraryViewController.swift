//
//  LibraryViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistViewController = LibraryPlaylistViewController()
    private let albumsViewController = LibraryAlbumsViewController()
    private let toggleView = LibraryToggleView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(scrollView, toggleView)
        scrollView.delegate = self
        toggleView.delegate = self
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        addChildren()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 55,
            width: view.width,
            height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55
        )
        toggleView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: 200,
            height: 55
        )
    }
    
    private func addChildren() {
        addChild(playlistViewController)
        scrollView.addSubview(playlistViewController.view)
        playlistViewController.view.frame = CGRect(
            x: 0,
            y: 0,
            width: scrollView.width,
            height: scrollView.height
        )
        playlistViewController.didMove(toParent: self)
        addChild(albumsViewController)
        scrollView.addSubview(albumsViewController.view)
        albumsViewController.view.frame = CGRect(
            x: view.width,
            y: 0,
            width: scrollView.width,
            height: scrollView.height
        )
        albumsViewController.didMove(toParent: self)
    }
}

//MARK: - UIScrollViewDelegate
extension LibraryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .album)
        } else {
            toggleView.update(for: .playlist)
        }
    }
}

//MARK: - LibraryToggleViewDelegate
extension LibraryViewController: LibraryToggleViewDelegate {
    
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
    }
}
