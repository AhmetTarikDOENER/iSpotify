//
//  PlayerViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {

    weak var dataSource: PlayerDataSource?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = .systemCyan
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(imageView, controlsView)
        controlsView.delegate = self
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width
        )
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom + 10,
            width: view.width - 20,
            height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15
        )
    }
    
    //MARK: - Private
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL)
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapCloseButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapActionButton)
        )
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapActionButton() {
        // Add action
    }
}

//MARK: - PlayerControlsViewDelegate
extension PlayerViewController: PlayerControlsViewDelegate {
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapPlayForwardsButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapPlayBackwardsButton(_ playerControlsView: PlayerControlsView) {
        
    }
}
