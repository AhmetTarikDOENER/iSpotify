//
//  GenresCollectionViewCell.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 12.02.2024.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenresCollectionViewCell"
    
    private let genresImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))

        
        return imageView
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(genresImageView, genresLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genresLabel.text = nil
        genresImageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        genresLabel.frame = CGRect(
            x: 10,
            y: contentView.height / 2,
            width: contentView.width - 20,
            height: contentView.height / 2
        )
        genresImageView.frame = CGRect(
            x: contentView.width / 2,
            y: 10,
            width: contentView.width / 2,
            height: contentView.height / 2
        )
    }
    
    private let colors: [UIColor] = [
        .systemRed, .systemBlue, .systemGreen, .systemPink, .systemCyan,
        .systemIndigo, .systemPurple, .systemYellow, .systemOrange, .systemGray,
        .systemMint, .systemTeal, .systemRed, .systemGray6, .secondarySystemFill, .tertiarySystemBackground, UIColor.magenta, UIColor.brown
    ]
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        genresLabel.text = viewModel.title
        genresImageView.sd_setImage(with: viewModel.artworkURL)
        contentView.backgroundColor = colors.randomElement()
    }
}
