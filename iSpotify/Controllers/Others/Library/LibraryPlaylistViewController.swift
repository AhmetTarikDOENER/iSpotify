//
//  LibraryPlaylistViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 14.02.2024.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNoPlaylistsView()
        fetchPlaylists()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    
    private func fetchPlaylists() {
        NetworkManager.shared.getCurrentUserPlaylists {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(
            with: .init(
                text: "You don't have any playlists yet.",
                actionTitle: "Create"
            )
        )
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            noPlaylistsView.isHidden = false
        } else {
            // Show tabel
        }
    }
}

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        let alert = UIAlertController(
            title: "New Playlists",
            message: "Enter playlist name",
            preferredStyle: .alert
        )
        alert.addTextField {
            textField in
            textField.placeholder = "Playlist..."
        }
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "Create",
                style: .default,
                handler: {
                    _ in
                    guard let field = alert.textFields?.first,
                          let text = field.text,
                          !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                        return
                    }
                    NetworkManager.shared.createPlaylist(with: text) {
                        success in
                        if success {
                            // Refresh list of playlists
                        } else {
                            print("Failed to create playlist.")
                        }
                    }
                }
            )
        )
        present(alert, animated: true)
    }
}
