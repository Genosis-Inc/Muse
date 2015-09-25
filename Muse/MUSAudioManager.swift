//
//  MUSAudioManager.swift
//  Muse
//
//  Created by Yuk Youngho on 2015. 9. 13..
//  Copyright (c) 2015년 Genosis. All rights reserved.
//

import Foundation
import MediaPlayer



/// Muse 음악 관리 클래스
class MUSAudioManager
{
    var sysMusicPlayer: MPMusicPlayerController! = nil
    
    init()
    {
        sysMusicPlayer = MPMusicPlayerController.systemMusicPlayer()
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.beginGeneratingPlaybackNotifications()
            sysMusicPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: MPMediaQuery.songsQuery().items!))
        }
    }
    
    deinit
    {
        
    }
    
    /// 현재 Playback을 재생 합니다.
    func play()
    {
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.play()
        }
    }
    
    /// 현재 재생중인 음악에서 다음 음악을 재생 합니다.
    func playNext()
    {
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.skipToNextItem()
            sysMusicPlayer.play()
        }
    }
    
    /// 현재 재생중인 음악의 이전 음악을 재생합니다.
    func playPrev()
    {
        sysMusicPlayer.skipToPreviousItem()
        sysMusicPlayer.play()
    }
}
