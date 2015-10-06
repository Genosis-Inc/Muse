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
    
    let audioPlayer : AudioPlayer = AudioPlayer()
    
    let defaultAlbumArtwork: MPMediaItemArtwork! = nil
    let defaultAlbumArtist: String = "Unknown Aritst"
    let defaultAlbumTitle: String = "Unknown Album"
    let defaultSongTitle: String = "Unknown Song"
    
    /// Playback 현재 음악 재생
    @IBAction func play(sender: UIButton)
    {
        let playbackState: MPMusicPlaybackState = audioPlayer.player.playbackState
        
        switch (playbackState)
        {
        case MPMusicPlaybackState.Paused:
            audioPlayer.player.play()
        case MPMusicPlaybackState.Playing:
            audioPlayer.player.pause()
        case MPMusicPlaybackState.Stopped:
            audioPlayer.player.play()
        default:
            break
        }
    }

    /// Playback 이전 음악 재생
    @IBAction func PlayPrev(sender: AnyObject)
    {
        audioPlayer.player.skipToPreviousItem()
    }
    
    /// Playback 다음 음악 재생
    @IBAction func PlayNext(sender: AnyObject)
    {
        audioPlayer.player.skipToNextItem()
    }
    
    
    /// 재생중인 음악이 변경되었을 경우 처리
    ///
    /// - 재생할 음악의 앨범 이미지
    /// - 재생할 음악의 타이틀
    /// - 재생할 음악의 아티스트 및 앨범 이름
    func NowPlayingItemDidChanged(notification: NSNotification)
    {
        guard let item = audioPlayer.player.nowPlayingItem else { return }
        
        let albumArtWork = item.artwork ?? defaultAlbumArtwork
        let albumArtist = item.albumArtist ?? defaultAlbumArtist
        let albumTitle = item.albumTitle ?? defaultAlbumTitle
        let songTitle = item.title ?? defaultSongTitle
        
        artWorkView.image = albumArtWork == nil ? nil :albumArtWork!.imageWithSize(artWorkView.intrinsicContentSize())
        lblTitle.text = songTitle
        lblArtistAlbum.text = String("\(albumArtist) - \(albumTitle)")
    }
    
    /// 재생 상태가 변경되었을 경우 처리
    ///
    /// MPMusicPlayerControllerPlaybackStateDidChangeNotification 이벤트 핸들러
    func PlaybakStateChanged(notification: NSNotification)
    {
        let playbackState: MPMusicPlaybackState = audioPlayer.player.playbackState
        
        switch (playbackState)
        {
        case MPMusicPlaybackState.Paused:
            btnPlayStop.setTitle("Play", forState: .Normal)
        case MPMusicPlaybackState.Playing:
            btnPlayStop.setTitle("Pause", forState: .Normal)
        case MPMusicPlaybackState.Stopped:
            btnPlayStop.setTitle("Play", forState: .Normal)
        default:
             break
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "NowPlayingItemDidChanged:",
                                                         name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "PlaybakStateChanged:",
                                                         name: MPMusicPlayerControllerPlaybackStateDidChangeNotification,
                                                         object: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

