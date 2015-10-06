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
    
    @IBOutlet weak var artWorkView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblArtistAlbum: UILabel!
    @IBOutlet var btnPlayStop: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Playback 현재 음악 재생
    @IBAction func play(sender: UIButton) {
        let playbackState: MPMusicPlaybackState = player.playbackState
        
        switch (playbackState) {
        case MPMusicPlaybackState.Playing:
            player.pause()
        case MPMusicPlaybackState.Stopped,
        MPMusicPlaybackState.Paused:
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
        
        artWorkView.image = item.artWork == nil ? nil : item.artWork!.imageWithSize(artWorkView.intrinsicContentSize())
        lblTitle.text = item.title
        lblArtistAlbum.text = String("\(item.artist) - \(item.album)")
    }
    
    /// `MPMusicPlayerControllerPlaybackStateDidChangeNotification`의 이벤트 핸들러
    func PlaybakStateChanged(notification: NSNotification) {
        let playbackState: MPMusicPlaybackState = player.playbackState
        
        switch (playbackState) {
        case MPMusicPlaybackState.Playing:
            btnPlayStop.setTitle("Pause", forState: .Normal)
        case MPMusicPlaybackState.Stopped,
        MPMusicPlaybackState.Paused:
            btnPlayStop.setTitle("Play", forState: .Normal)
        default:
             break
        }
    }
}