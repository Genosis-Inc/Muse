//
//  ViewController.swift
//  Muse
//
//  Created by Dongkyu Shin on 2015. 9. 3..
//  Copyright (c) 2015년 Genosis. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistAlbumLabel: UILabel!
    @IBOutlet var playStopButton: UIButton!
    @IBOutlet var shuffleModeButton: UIButton!
    
    let player = MPMusicPlayerController.applicationMusicPlayer()
    
    // TODO: Artwork의 기본 이미지를 정해야 합니다.
    let defaultAlbumArtwork: MPMediaItemArtwork! = nil
    let defaultAlbumArtist: String = "Unknown Aritst"
    let defaultAlbumTitle: String = "Unknown Album"
    let defaultSongTitle: String = "Unknown Song"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Device의 모든 곡을 조회하여 Player의 Queue에 담습니다.
        let mediaItems = MPMediaQuery.songsQuery().items!
        player.setQueueWithItemCollection(MPMediaItemCollection(items: mediaItems))
        
        // 현재 곡을 첫번째 곡으로 설정합니다.
        player.nowPlayingItem = mediaItems.first as MPMediaItem?
        
        // Shuffle Mode 를 설정합니다.
        player.shuffleMode = .Off
        
        // Notification을 등록 합니다.
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "NowPlayingItemDidChanged:",
            name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "PlaybakStateChanged:",
            name: MPMusicPlayerControllerPlaybackStateDidChangeNotification,
            object: nil)
        
        player.beginGeneratingPlaybackNotifications()
    }
    
    deinit {
        player.endGeneratingPlaybackNotifications()
    }
    
    /// Muse 재생 화면을 출력합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayShuffleMode()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Shuffle mode를 변경 합니다.
    /// - parameter sender: shuffle mode button
    @IBAction func setShuffleMode(sender: AnyObject) {
        let shuffleMode = player.shuffleMode
        
        switch (shuffleMode) {
        case .Songs, .Albums, .Default:
            player.shuffleMode = .Off
        case .Off:
            player.shuffleMode = .Songs
        }
        
        displayShuffleMode()
    }
    
    /// Playback 현재 음악 재생
    /// play 버튼은 play / pause 두 개의 동작을 toggle 합니다.
    @IBAction func play(sender: UIButton) {
        let playbackState: MPMusicPlaybackState = player.playbackState
        
        switch (playbackState) {
        case MPMusicPlaybackState.Playing:
            player.pause()
        case MPMusicPlaybackState.Stopped, MPMusicPlaybackState.Paused:
            player.play()
        default:
            break
        }
    }

    /// Playback 이전 음악 재생
    @IBAction func PlayPrev(sender: AnyObject) {
        player.skipToPreviousItem()
    }
    
    /// Playback 다음 음악 재생
    @IBAction func PlayNext(sender: AnyObject) {
        player.skipToNextItem()
    }
    
    /// MPMediaItem의 정보를 반환합니다.
    /// - parameter item: `MPMediaItem`
    /// - returns: artWork: 앨범의 이미지
    ///            artist: 아티스트 명
    ///            album: 앨범 명
    ///            title: 노래 명
    func getItem(item: MPMediaItem) -> (artWork: MPMediaItemArtwork!, artist: String, album: String, title: String) {
        return (item.artwork ?? defaultAlbumArtwork,
            item.albumArtist ?? defaultAlbumArtist,
            item.albumTitle ?? defaultAlbumTitle,
            item.title ?? defaultSongTitle)
    }
    
    /// `MPMusicPlayerControllerNowPlayingItemDidChangeNotification`의 이벤트 핸들러
    func NowPlayingItemDidChanged(notification: NSNotification) {
        guard let playingItem = player.nowPlayingItem else { return }
        
        let item = getItem(playingItem)
        
        artWorkImageView.image = item.artWork == nil ? nil : item.artWork!.imageWithSize(artWorkImageView.intrinsicContentSize())
        titleLabel.text = item.title
        artistAlbumLabel.text = String("\(item.artist) - \(item.album)")
    }
    
    /// `MPMusicPlayerControllerPlaybackStateDidChangeNotification`의 이벤트 핸들러
    func PlaybakStateChanged(notification: NSNotification) {
        let playbackState: MPMusicPlaybackState = player.playbackState
        
        switch (playbackState) {
        case MPMusicPlaybackState.Playing:
            playStopButton.setTitle("Pause", forState: .Normal)
        case MPMusicPlaybackState.Stopped,
        MPMusicPlaybackState.Paused:
            playStopButton.setTitle("Play", forState: .Normal)
        default:
             break
        }
    }
    
    /// Shuffle mode 설명을 화면에 출력 합니다.
    func displayShuffleMode() {
        // TODO: 어떤 shuffle mode인지 명시적으로 사용자에게 알려줬으면 합니다.
        let shuffleMode = player.shuffleMode
        
        switch (shuffleMode) {
        case .Off:
            shuffleModeButton.setTitle("Off", forState: .Normal)
        case .Default:
            shuffleModeButton.setTitle("Default", forState: .Normal)
        case .Albums:
            shuffleModeButton.setTitle("Albums", forState: .Normal)
        case .Songs:
            shuffleModeButton.setTitle("Songs", forState: .Normal)
        }
    }
}