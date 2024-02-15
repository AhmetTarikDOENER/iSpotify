//
//  PlaylistHeaderCollectionReusableView.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 11.02.2024.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 25,
                weight: .regular
            )
        )
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(nameLabel, descriptionLabel, ownerLabel, playlistImageView, playAllButton)
        playAllButton.addTarget(
            self,
            action: #selector(didTapPlayAllButton),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height / 1.5
        playlistImageView.frame = CGRect(
            x: (width - imageSize) / 2,
            y: 20,
            width: imageSize,
            height: imageSize
        )
        nameLabel.frame = CGRect(
            x: 10,
            y: playlistImageView.bottom,
            width: width - 20,
            height: 44
        )
        descriptionLabel.frame = CGRect(
            x: 10,
            y: nameLabel.bottom,
            width: width - 20,
            height: 44
        )
        ownerLabel.frame = CGRect(
            x: 10,
            y: descriptionLabel.bottom,
            width: width - 20,
            height: 44
        )
        playAllButton.frame = CGRect(
            x: width - 80,
            y: height - 50,
            width: 40,
            height: 40
        )
    }
    
    @objc private func didTapPlayAllButton() {
        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        playlistImageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"))
    }
}
