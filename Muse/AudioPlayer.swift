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
}
