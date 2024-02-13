//
//  TitleHeaderCollectionReusableView.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 11.02.2024.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(
            x: 15,
            y: 0,
            width: width - 30,
            height: height
        )
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
