//
//  PlayerControlsView.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 13.02.2024.
//

import UIKit.UIView

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapPlayForwardsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapPlayBackwardsButton(_ playerControlsView: PlayerControlsView)
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "This is my song"
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Drake (feat. Some Other Artist)"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let backsButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "backward.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
            ),
            for: .normal
        )
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "forward.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
            ),
            for: .normal
        )
        
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "pause",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
            ),
            for: .normal
        )
        
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews(nameLabel, subtitleLabel, volumeSlider, backsButton, nextButton, playPauseButton)
        clipsToBounds = true
        
        backsButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 40)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom, width: width, height: 50)
        volumeSlider.frame = CGRect(
            x: 30,
            y: subtitleLabel.bottom + 20,
            width: width - 60,
            height: 44
        )
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(
            x: (width - buttonSize) / 2,
            y: volumeSlider.bottom + 30,
            width: buttonSize,
            height: buttonSize
        )
        backsButton.frame = CGRect(
            x: playPauseButton.left - buttonSize - 60,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
        nextButton.frame = CGRect(
            x: playPauseButton.right + 60,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
    }
    
    @objc private func didTapBackButton() {
        delegate?.playerControlsViewDidTapPlayBackwardsButton(self)
    }
    
    @objc private func didTapNextButton() {
        delegate?.playerControlsViewDidTapPlayForwardsButton(self)
    }
    
    @objc private func didTapPlayPauseButton() {
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
}
