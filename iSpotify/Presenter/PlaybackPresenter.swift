//
//  PlaybackPresenter.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 13.02.2024.
//

import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    private init () {}
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var player: AVPlayer?
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if !tracks.isEmpty {
            return tracks.first
        }
        return nil
    }
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        guard let url = URL(string: track.preview_url ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.1
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) {
            [weak self] in
            self?.player?.play()
        }
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didTapPlayPause() {
        if let player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else {
            
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else {
            
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

//MARK: - PlayerDataSource
extension PlaybackPresenter: PlayerDataSource {
    
    var songName: String? {
        currentTrack?.name
    }
    
    var subtitle: String? {
        currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
