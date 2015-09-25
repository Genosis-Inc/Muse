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
        // 1. SystemMusicPlayer 인스턴스 생성
        sysMusicPlayer = MPMusicPlayerController.systemMusicPlayer()
        
        // 2. Notification 등록
        sysMusicPlayer.beginGeneratingPlaybackNotifications()
        
        // 3. Playback 설정
        sysMusicPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: MPMediaQuery.songsQuery().items!))
    }
    
    deinit
    {
        sysMusicPlayer.endGeneratingPlaybackNotifications()
    }
    
    /// 현재 Playback을 재생 합니다.
    func play()
    {
        sysMusicPlayer.play()
    }
    
    /// 재생을 일시중지 한다.
    func pause()
    {
        sysMusicPlayer.pause()
    }
    
    /// 재생을 멈춘다.
    func stop()
    {
        sysMusicPlayer.stop()
    }
    
    /// 현재 재생중인 음악에서 다음 음악을 재생 합니다.
    func playNext()
    {
        sysMusicPlayer.skipToNextItem()
        sysMusicPlayer.play()
    }
    
    /// 현재 재생중인 음악의 이전 음악을 재생합니다.
    func playPrev()
    {
        sysMusicPlayer.skipToPreviousItem()
        sysMusicPlayer.play()
    }
    
    /// 현재 Playback state 리턴한다.
    func getPlaybackState() -> MPMusicPlaybackState
    {
        return sysMusicPlayer.playbackState
    }
}
