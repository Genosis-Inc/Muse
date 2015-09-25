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
    
    let MUSAudioMgr : MUSAudioManager = MUSAudioManager()
    
    @IBOutlet weak var artWorkView: UIImageView!
    @IBOutlet var btnPlayStop: UIButton!
    
    /// Playback 현재 음악 재생
    @IBAction func play(sender: UIButton)
    {
        let playbackState: MPMusicPlaybackState = MUSAudioMgr.getPlaybackState()
        
        switch (playbackState)
        {
        case MPMusicPlaybackState.Paused:
            MUSAudioMgr.play()
            break
        case MPMusicPlaybackState.Playing:
            MUSAudioMgr.pause()
            break
        case MPMusicPlaybackState.Stopped:
            MUSAudioMgr.play()
            break
        default:
            break
        }
    }

    /// Playback 이전 음악 재생
    @IBAction func PlayPrev(sender: AnyObject)
    {
        MUSAudioMgr.playPrev()
    }
    
    /// Playback 다음 음악 재생
    @IBAction func PlayNext(sender: AnyObject)
    {
        MUSAudioMgr.playNext()
    }
    
    
    /// 재생중인 음악이 변경되었을 경우 처리
    ///
    /// MPMusicPlayerControllerNowPlayingItemDidChangeNotification
    /// 재생 변경된 음악의 앨범을 출력한다.
    func NowPlayingItemDidChanged(notification: NSNotification)
    {
        artWorkView.image = MUSAudioMgr.sysMusicPlayer.nowPlayingItem!.artwork!.imageWithSize(artWorkView.intrinsicContentSize())
    }
    
    /// 재생 상태가 변경되었을 경우 처리
    ///
    /// MPMusicPlayerControllerPlaybackStateDidChangeNotification 이벤트 핸들러
    func PlaybakStateChanged(notification: NSNotification)
    {
        let playbackState: MPMusicPlaybackState = MUSAudioMgr.getPlaybackState()
        
        switch (playbackState)
        {
        case MPMusicPlaybackState.Paused:
            btnPlayStop.setTitle("Play", forState: .Normal)
            break
        case MPMusicPlaybackState.Playing:
            btnPlayStop.setTitle("Pause", forState: .Normal)
            break
        case MPMusicPlaybackState.Stopped:
            btnPlayStop.setTitle("Play", forState: .Normal)
            break
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

