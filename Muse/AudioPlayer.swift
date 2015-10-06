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
    var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer()
    
    init()
    {
        // Playback 설정
        let mediaItems = MPMediaQuery.songsQuery().items!
        player.setQueueWithItemCollection(MPMediaItemCollection(items: mediaItems))
        player.nowPlayingItem = mediaItems.first as MPMediaItem?
        
        // Notification 등록
        player.beginGeneratingPlaybackNotifications()
    }
    
    deinit
    {
        player.endGeneratingPlaybackNotifications()
    }
}
