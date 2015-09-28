//
//  AudioPlayer.swift
//  Muse
//
//  Created by Yuk Youngho on 2015. 9. 28..
//  Copyright © 2015년 Genosis. All rights reserved.
//

import Foundation
import MediaPlayer



/// 오디오 플레이어
class AudioPlayer
{
    var player: MPMusicPlayerController! = nil
    
    init()
    {
        // SystemMusicPlayer 인스턴스 생성
        player = MPMusicPlayerController.systemMusicPlayer()
        
        // Notification 등록
        player.beginGeneratingPlaybackNotifications()
        
        // Playback 설정
        player.setQueueWithItemCollection(MPMediaItemCollection(items: MPMediaQuery.songsQuery().items!))
    }
    
    deinit
    {
        player.endGeneratingPlaybackNotifications()
    }
    
    /// 현재 Playback을 재생 합니다.
    func play()
    {
        player.play()
    }
    
    /// 재생을 일시중지 한다.
    func pause()
    {
        player.pause()
    }
    
    /// 재생을 멈춘다.
    func stop()
    {
        player.stop()
    }
    
    /// 현재 재생중인 음악에서 다음 음악을 재생 합니다.
    func playNext()
    {
        player.skipToNextItem()
    }
    
    /// 현재 재생중인 음악의 이전 음악을 재생합니다.
    func playPrev()
    {
        player.skipToPreviousItem()
    }
    
    /// 현재 Playback state 리턴한다.
    func getPlaybackState() -> MPMusicPlaybackState
    {
        return player.playbackState
    }
}
